import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Lightweight cache combining in-memory storage with SharedPreferences backup.
class CacheService {
  CacheService({
    SharedPreferences? preferences,
    this.defaultTtl = const Duration(minutes: 10),
  }) : _preferencesFuture = preferences != null
           ? Future.value(preferences)
           : SharedPreferences.getInstance();

  final Future<SharedPreferences> _preferencesFuture;
  final Duration defaultTtl;

  static const _prefsPrefix = 'cache:';

  final _memory = <String, _CacheEntry>{};

  Future<void> save(
    String key,
    Map<String, dynamic> data, {
    Duration? ttl,
  }) async {
    final expiresAt = DateTime.now().add(ttl ?? defaultTtl);
    final entry = _CacheEntry(
      data: Map<String, dynamic>.from(data),
      expiresAt: expiresAt,
    );
    _memory[key] = entry;

    final prefs = await _preferencesFuture;
    await prefs.setString(
      _prefsKey(key),
      jsonEncode({
        'expiresAt': expiresAt.toIso8601String(),
        'data': _sanitize(entry.data),
      }),
    );
  }

  Future<Map<String, dynamic>?> load(String key) async {
    final memoryEntry = _memory[key];
    if (memoryEntry != null && !_isExpired(memoryEntry)) {
      return memoryEntry.data;
    }

    final prefs = await _preferencesFuture;
    final raw = prefs.getString(_prefsKey(key));
    if (raw == null) {
      return null;
    }

    try {
      final decoded = jsonDecode(raw) as Map<String, dynamic>;
      final expiresAtStr = decoded['expiresAt'] as String?;
      if (expiresAtStr == null) {
        await remove(key);
        return null;
      }
      final expiresAt = DateTime.tryParse(expiresAtStr);
      if (expiresAt == null || expiresAt.isBefore(DateTime.now())) {
        await remove(key);
        return null;
      }
      final data = Map<String, dynamic>.from(decoded['data'] as Map);
      final entry = _CacheEntry(data: data, expiresAt: expiresAt);
      _memory[key] = entry;
      return data;
    } on FormatException {
      await remove(key);
      return null;
    }
  }

  Future<void> remove(String key) async {
    _memory.remove(key);
    final prefs = await _preferencesFuture;
    await prefs.remove(_prefsKey(key));
  }

  Future<void> clear() async {
    _memory.clear();
    final prefs = await _preferencesFuture;
    final keys = prefs
        .getKeys()
        .where((k) => k.startsWith(_prefsPrefix))
        .toList();
    for (final key in keys) {
      await prefs.remove(key);
    }
  }

  bool _isExpired(_CacheEntry entry) =>
      entry.expiresAt.isBefore(DateTime.now());

  String _prefsKey(String key) => '$_prefsPrefix$key';
}

class _CacheEntry {
  _CacheEntry({required this.data, required this.expiresAt});

  final Map<String, dynamic> data;
  final DateTime expiresAt;
}

final cacheServiceProvider = Provider<CacheService>((ref) => CacheService());

Map<String, dynamic> _sanitize(Map<String, dynamic> data) {
  return data.map((key, value) => MapEntry(key, _sanitizeValue(value)));
}

Object? _sanitizeValue(Object? value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate().toIso8601String();
  if (value is DateTime) return value.toIso8601String();
  if (value is Map) {
    return Map<String, dynamic>.fromEntries(
      value.entries.map(
        (entry) => MapEntry(entry.key.toString(), _sanitizeValue(entry.value)),
      ),
    );
  }
  if (value is Iterable) {
    return value.map(_sanitizeValue).toList();
  }
  if (value is num || value is String || value is bool) {
    return value;
  }
  return value.toString();
}
