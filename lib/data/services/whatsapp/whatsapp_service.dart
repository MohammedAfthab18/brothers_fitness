import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../core/errors/exceptions.dart';
import '../local/cache_service.dart';
import 'message_templates.dart';

typedef WhatsAppTokenSupplier = Future<WhatsAppAccessToken> Function();

class WhatsAppServiceConfig {
  const WhatsAppServiceConfig({
    required this.phoneNumberId,
    required this.tokenSupplier,
    this.graphVersion = 'v19.0',
  });

  final String phoneNumberId;
  final WhatsAppTokenSupplier tokenSupplier;
  final String graphVersion;
}

class WhatsAppAccessToken {
  const WhatsAppAccessToken({
    required this.token,
    this.expiresIn = const Duration(minutes: 55),
  });

  final String token;
  final Duration expiresIn;
}

class WhatsAppService {
  WhatsAppService({
    required this.phoneNumberId,
    required CacheService cacheService,
    required WhatsAppTokenSupplier tokenSupplier,
    String graphVersion = 'v19.0',
    http.Client? httpClient,
  }) : _cacheService = cacheService,
       _tokenSupplier = tokenSupplier,
       _graphVersion = graphVersion,
       _client = httpClient ?? http.Client();

  final String phoneNumberId;
  final CacheService _cacheService;
  final WhatsAppTokenSupplier _tokenSupplier;
  final String _graphVersion;
  final http.Client _client;

  static const _tokenCacheKey = 'whatsapp:token';

  Uri get _messagesUri => Uri.https(
    'graph.facebook.com',
    '/$_graphVersion/$phoneNumberId/messages',
  );

  Future<void> sendTextMessage({
    required String recipient,
    required String message,
  }) async {
    await _sendRequest({
      'messaging_product': 'whatsapp',
      'to': recipient,
      'type': 'text',
      'text': {'preview_url': false, 'body': message},
    });
  }

  Future<void> sendTemplateMessage({
    required String recipient,
    required WhatsAppTemplate template,
    Map<String, String>? variables,
  }) async {
    final payload = template.buildPayload(
      recipient: recipient,
      values: variables,
    );
    await _sendRequest(payload);
  }

  Future<void> sendMediaMessage({
    required String recipient,
    required String mediaUrl,
    required String mediaType,
    String? caption,
    String? filename,
  }) async {
    final supportedTypes = {'image', 'video', 'audio', 'document', 'sticker'};
    if (!supportedTypes.contains(mediaType)) {
      throw const AppException(message: 'Unsupported media type');
    }

    final mediaPayload = {
      'link': mediaUrl,
      if (caption != null) 'caption': caption,
      if (filename != null && mediaType == 'document') 'filename': filename,
    };

    await _sendRequest({
      'messaging_product': 'whatsapp',
      'to': recipient,
      'type': mediaType,
      mediaType: mediaPayload,
    });
  }

  Future<void> refreshAccessToken() async {
    final fresh = await _tokenSupplier();
    await _cacheService.save(_tokenCacheKey, {
      'token': fresh.token,
    }, ttl: fresh.expiresIn);
  }

  Future<void> _sendRequest(Map<String, dynamic> payload) async {
    final token = await _getAccessToken();
    final response = await _client.post(
      _messagesUri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }

    throw AppException(
      message: 'WhatsApp API error (${response.statusCode})',
      cause: response.body,
    );
  }

  Future<String> _getAccessToken({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cached = await _cacheService.load(_tokenCacheKey);
      final token = cached?['token'] as String?;
      if (token != null) {
        return token;
      }
    }

    final fresh = await _tokenSupplier();
    await _cacheService.save(_tokenCacheKey, {
      'token': fresh.token,
    }, ttl: fresh.expiresIn);
    return fresh.token;
  }
}

final whatsappServiceProvider =
    Provider.family<WhatsAppService, WhatsAppServiceConfig>((ref, config) {
      final cache = ref.watch(cacheServiceProvider);
      return WhatsAppService(
        phoneNumberId: config.phoneNumberId,
        cacheService: cache,
        tokenSupplier: config.tokenSupplier,
        graphVersion: config.graphVersion,
      );
    });
