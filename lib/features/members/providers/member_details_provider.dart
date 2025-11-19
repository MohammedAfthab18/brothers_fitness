import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/attendance/attendance.dart';
import '../../../data/models/member/member.dart';
import '../../../data/models/payment/payment.dart';
import '../../../data/repositories/attendance_repository.dart';
import '../../../data/repositories/members_repository.dart';
import '../../../data/repositories/payments_repository.dart';

final memberDetailsProvider =
    FutureProvider.autoDispose.family<Member, String>((ref, memberId) async {
  final repository = ref.watch(membersRepositoryProvider);
  final member = await repository.getMember(memberId);
  if (member == null) {
    throw StateError('Member not found');
  }
  return member;
});

final memberPaymentsProvider = FutureProvider.autoDispose
    .family<List<Payment>, String>((ref, memberId) async {
  final repository = ref.watch(paymentsRepositoryProvider);
  return repository.getPaymentsByMember(memberId);
});

final memberAttendanceProvider = FutureProvider.autoDispose
    .family<List<Attendance>, String>((ref, memberId) async {
  final repository = ref.watch(attendanceRepositoryProvider);
  return repository.getAttendanceForMember(memberId);
});