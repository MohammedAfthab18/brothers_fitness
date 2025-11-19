/// Magic numbers, limits, and app-wide constants.
class AppConstants {
  AppConstants._();

  // Member limits
  static const int maxMemberNameLength = 100;
  static const int maxPhoneLength = 15;
  static const int maxNotesLength = 5000;

  // Plan limits
  static const int minPlanDurationDays = 1;
  static const int maxPlanDurationDays = 365;
  static const double minPlanPrice = 0.0;
  static const double maxPlanPrice = 100000.0;

  // Payment limits
  static const double minPaymentAmount = 0.01;
  static const double maxPaymentAmount = 100000.0;

  // Attendance limits
  static const int maxDailyCheckIns = 10; // Prevent abuse
  static const Duration minCheckInInterval = Duration(minutes: 5);

  // List limits
  static const int maxMembersPerPage = 50;
  static const int maxPaymentsPerPage = 100;
  static const int maxPlansPerPage = 50;

  // Cache keys
  static const String cacheKeyMembers = 'members';
  static const String cacheKeyPlans = 'plans';
  static const String cacheKeyRecentPayments = 'payments_recent';
  static const String cacheKeyPendingPayments = 'payments_pending';

  // Member status values
  static const String memberStatusActive = 'active';
  static const String memberStatusExpired = 'expired';
  static const String memberStatusPaused = 'paused';

  // Payment methods
  static const String paymentMethodCash = 'cash';
  static const String paymentMethodCard = 'card';
  static const String paymentMethodTransfer = 'transfer';
  static const String paymentMethodUPI = 'upi';

  // User roles
  static const String userRoleOwner = 'owner';
  static const String userRoleAdmin = 'admin';
  static const String userRoleStaff = 'staff';

  // Date ranges
  static const int defaultReportDays = 30;
  static const int maxReportDays = 365;

  // Validation
  static const String phoneRegex =
      r'^[+]?[(]?[0-9]{1,4}[)]?[-\s.]?[(]?[0-9]{1,4}[)]?[-\s.]?[0-9]{1,9}$';
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  // Debounce timers
  static const Duration searchDebounce = Duration(milliseconds: 300);
  static const Duration autoSaveDebounce = Duration(seconds: 2);
}
