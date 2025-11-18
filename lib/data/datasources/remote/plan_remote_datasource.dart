import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/plan/plan.dart';
import '../../services/firebase/firestore_service.dart';

class PlanRemoteDataSource {
  PlanRemoteDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  static const _collectionPath = 'plans';

  Future<List<Plan>> getPlans() {
    return _firestoreService.getCollection<Plan>(
      path: _collectionPath,
      fromJson: Plan.fromJson,
    );
  }

  Future<void> createPlan(Plan plan) {
    return _firestoreService.setDocument(
      path: '$_collectionPath/${plan.id}',
      data: plan.toFirestore(),
    );
  }

  Future<void> updatePlan(Plan plan) {
    return _firestoreService.updateDocument(
      path: '$_collectionPath/${plan.id}',
      data: plan.toFirestore(),
    );
  }

  Future<void> togglePlanStatus({
    required String planId,
    required bool isActive,
  }) {
    return _firestoreService.updateDocument(
      path: '$_collectionPath/$planId',
      data: {'isActive': isActive},
    );
  }
}

final planRemoteDataSourceProvider = Provider<PlanRemoteDataSource>((ref) {
  final firestore = ref.watch(firestoreServiceProvider);
  return PlanRemoteDataSource(firestore);
});
