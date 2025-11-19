/// Route names and navigation constants.
class RouteConstants {
  RouteConstants._();

  // Auth routes
  static const String login = '/login';
  static const String splash = '/splash';

  // Dashboard
  static const String dashboard = '/dashboard';
  static const String home = '/';

  // Members
  static const String members = '/members';
  static const String memberDetail = '/members/:id';
  static const String memberCreate = '/members/create';
  static const String memberEdit = '/members/:id/edit';

  // Plans
  static const String plans = '/plans';
  static const String planCreate = '/plans/create';
  static const String planEdit = '/plans/:id/edit';

  // Payments
  static const String payments = '/payments';
  static const String paymentCreate = '/payments/create';
  static const String paymentDetail = '/payments/:id';

  // Attendance
  static const String attendance = '/attendance';
  static const String attendanceToday = '/attendance/today';

  // Reminders
  static const String reminders = '/reminders';
  static const String reminderCreate = '/reminders/create';
  static const String reminderEdit = '/reminders/:id/edit';

  // Settings
  static const String settings = '/settings';
  static const String settingsProfile = '/settings/profile';
  static const String settingsGeneral = '/settings/general';
  static const String settingsWhatsApp = '/settings/whatsapp';

  // Reports
  static const String reports = '/reports';
  static const String reportsRevenue = '/reports/revenue';
  static const String reportsAttendance = '/reports/attendance';
  static const String reportsMembers = '/reports/members';

  // Helper methods
  static String memberDetailPath(String id) => '/members/$id';
  static String memberEditPath(String id) => '/members/$id/edit';
  static String planEditPath(String id) => '/plans/$id/edit';
  static String paymentDetailPath(String id) => '/payments/$id';
  static String reminderEditPath(String id) => '/reminders/$id/edit';
}
