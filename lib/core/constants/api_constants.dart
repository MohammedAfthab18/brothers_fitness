/// API endpoints and external service URLs.
class ApiConstants {
  ApiConstants._();

  // Firebase (handled via firebase_options.dart)
  // WhatsApp Cloud API
  static String whatsAppMessagesUrl(String phoneNumberId) =>
      'https://graph.facebook.com/v19.0/$phoneNumberId/messages';

  static String whatsAppMediaUrl(String phoneNumberId) =>
      'https://graph.facebook.com/v19.0/$phoneNumberId/media';

  // Timeout durations
  static const Duration requestTimeout = Duration(seconds: 30);
  static const Duration connectionTimeout = Duration(seconds: 10);

  // Retry configuration
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
