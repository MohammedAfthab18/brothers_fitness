/// App-wide configuration constants.
class AppConfig {
  AppConfig._();

  // App metadata
  static const String appName = 'Brothers Fitness';
  static const String appVersion = '1.0.0';
  static const String appPackageName = 'com.brothersfitness.app';

  // Cache configuration
  static const Duration defaultCacheTtl = Duration(minutes: 5);
  static const Duration longCacheTtl = Duration(hours: 1);
  static const Duration shortCacheTtl = Duration(minutes: 1);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Image configuration
  static const int maxImageSizeBytes = 5 * 1024 * 1024; // 5MB
  static const int imageCompressionQuality = 85;

  // Search configuration
  static const int minSearchQueryLength = 2;
  static const int maxSearchResults = 50;

  // Date/Time formatting
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy hh:mm a';

  // Environment
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');
  static const bool isDevelopment = !isProduction;

  // Debug flags
  static const bool enableLogging = isDevelopment;
  static const bool enablePerformanceMonitoring = isProduction;
}
