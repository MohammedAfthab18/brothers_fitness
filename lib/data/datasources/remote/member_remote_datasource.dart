import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/member/member.dart';
import '../../services/firebase/firestore_service.dart';

class MemberRemoteDataSource {
  MemberRemoteDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  static const _collectionPath = 'members';

  Future<Member?> getMemberById(String id, {bool forceRefresh = false}) {
    return _firestoreService.getDocument<Member>(
      path: '$_collectionPath/$id',
      fromJson: Member.fromJson,
      forceRefresh: forceRefresh,
    );
  }

  Future<List<Member>> getMembers({
    Query<Map<String, dynamic>> Function(
      CollectionReference<Map<String, dynamic>>,
    )?
    queryBuilder,
  }) {
    return _firestoreService.getCollection<Member>(
      path: _collectionPath,
      fromJson: Member.fromJson,
      queryBuilder: queryBuilder,
    );
  }

  Future<void> createMember(Member member) {
    return _firestoreService.setDocument(
      path: '$_collectionPath/${member.id}',
      data: member.toFirestore(),
    );
  }

  Future<void> updateMember(Member member) {
    return _firestoreService.updateDocument(
      path: '$_collectionPath/${member.id}',
      data: member.toFirestore(),
    );
  }

  Future<void> deleteMember(String id) {
    return _firestoreService.deleteDocument('$_collectionPath/$id');
  }
}

final memberRemoteDataSourceProvider = Provider<MemberRemoteDataSource>((ref) {
  final firestore = ref.watch(firestoreServiceProvider);
  return MemberRemoteDataSource(firestore);
});
