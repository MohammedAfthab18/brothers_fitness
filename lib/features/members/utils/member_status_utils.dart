import '../../../shared/widgets/indicators/status_badge.dart';

MemberStatus memberStatusFromString(String value) {
  switch (value.toLowerCase()) {
    case 'expiring':
      return MemberStatus.expiring;
    case 'expired':
      return MemberStatus.expired;
    case 'active':
    default:
      return MemberStatus.active;
  }
}

String memberStatusToString(MemberStatus status) {
  switch (status) {
    case MemberStatus.active:
      return 'active';
    case MemberStatus.expiring:
      return 'expiring';
    case MemberStatus.expired:
      return 'expired';
  }
}

