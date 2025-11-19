import 'package:cloud_firestore/cloud_firestore.dart';

/// Firestore offline persistence configuration.
class FirestoreConfig {
  FirestoreConfig._();

  /// Initialize Firestore with offline persistence enabled.
  ///
  /// This enables automatic caching of Firestore data for offline access.
  /// The cache persists across app restarts.
  static Future<void> initialize() async {
    final firestore = FirebaseFirestore.instance;

    // Enable offline persistence (enabled by default on mobile)
    // For desktop, we explicitly set it
    firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  /// Clear Firestore cache (useful for testing or forced refresh).
  static Future<void> clearCache() async {
    await FirebaseFirestore.instance.clearPersistence();
  }
}
