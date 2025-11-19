/// WhatsApp Cloud API configuration.
///
/// These values should be set via environment variables or secure storage
/// in production. For now, they are placeholders.
class WhatsAppConfig {
  WhatsAppConfig._();

  // WhatsApp Cloud API credentials
  // TODO: Move to environment variables or secure storage
  static String? phoneNumberId;
  static String? accessToken;
  static String? businessAccountId;

  // Graph API version
  static const String graphApiVersion = 'v19.0';

  // Base URL
  static String get baseUrl => 'https://graph.facebook.com/$graphApiVersion';

  // Message limits
  static const int maxMessageLength = 4096;
  static const int maxTemplateParams = 10;

  // Rate limiting
  static const int maxMessagesPerMinute = 1000;
  static const int maxMessagesPerDay = 1000000;

  // Template names (must match WhatsApp Business Manager)
  static const String templatePaymentReminder = 'payment_reminder';
  static const String templateRenewalReminder = 'renewal_reminder';
  static const String templateWelcome = 'welcome_message';
  static const String templateAttendanceSuccess = 'attendance_success';

  /// Initialize WhatsApp configuration.
  ///
  /// In production, load these from secure storage or environment variables.
  static Future<void> initialize({
    String? phoneNumberId,
    String? accessToken,
    String? businessAccountId,
  }) async {
    WhatsAppConfig.phoneNumberId = phoneNumberId;
    WhatsAppConfig.accessToken = accessToken;
    WhatsAppConfig.businessAccountId = businessAccountId;
  }

  /// Check if WhatsApp is configured.
  static bool get isConfigured => phoneNumberId != null && accessToken != null;
}
