import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/attendance/attendance.dart';
import '../../services/firebase/firestore_service.dart';

class AttendanceRemoteDataSource {
  AttendanceRemoteDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  static const _collectionPath = 'attendance';

  Future<void> markCheckIn(Attendance attendance) {
    final data = Map<String, dynamic>.from(attendance.toJson())..remove('id');
    return _firestoreService.setDocument(
      path: '$_collectionPath/${attendance.id}',
      data: data,
    );
  }

  Future<void> markCheckOut(String attendanceId, DateTime time) {
    return _firestoreService.updateDocument(
      path: '$_collectionPath/$attendanceId',
      data: {'checkOutTime': Timestamp.fromDate(time)},
    );
  }

  Future<List<Attendance>> getAttendanceForMember(String memberId) {
    return _firestoreService.getCollection<Attendance>(
      path: _collectionPath,
      fromJson: Attendance.fromJson,
      queryBuilder: (collection) => collection
          .where('memberId', isEqualTo: memberId)
          .orderBy('checkInTime', descending: true),
    );
  }

  Future<List<Attendance>> getAttendanceForDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final endExclusive = start.add(const Duration(days: 1));
    return _firestoreService.getCollection<Attendance>(
      path: _collectionPath,
      fromJson: Attendance.fromJson,
      queryBuilder: (collection) => collection
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
          .where('date', isLessThan: Timestamp.fromDate(endExclusive))
          .orderBy('date')
          .orderBy('checkInTime'),
    );
  }
}

final attendanceRemoteDataSourceProvider = Provider<AttendanceRemoteDataSource>(
  (ref) {
    final firestore = ref.watch(firestoreServiceProvider);
    return AttendanceRemoteDataSource(firestore);
  },
);
