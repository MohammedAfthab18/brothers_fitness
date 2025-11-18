import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/remote/attendance_remote_datasource.dart';
import '../models/attendance/attendance.dart';

class AttendanceRepository {
  AttendanceRepository({required AttendanceRemoteDataSource remote})
    : _remote = remote;

  final AttendanceRemoteDataSource _remote;

  Future<void> markCheckIn(Attendance attendance) {
    return _remote.markCheckIn(attendance);
  }

  Future<void> markCheckOut(String attendanceId, DateTime time) {
    return _remote.markCheckOut(attendanceId, time);
  }

  Future<List<Attendance>> getAttendanceForMember(String memberId) {
    return _remote.getAttendanceForMember(memberId);
  }

  Future<List<Attendance>> getAttendanceForDate(DateTime date) {
    return _remote.getAttendanceForDate(date);
  }
}

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final remote = ref.read(attendanceRemoteDataSourceProvider);
  return AttendanceRepository(remote: remote);
});
