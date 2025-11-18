import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/plan/plan.dart';
import '../../services/firebase/firestore_service.dart';
import '../local/cache_datasource.dart';

class PlanRemoteDataSource {
  PlanRemoteDataSource(this._firestoreService, this._cacheDatasource);

  final FirestoreService _firestoreService;
  final CacheDatasource _cacheDatasource;

  static const _collectionPath = 'plans';
  static const _listCacheKey = 'plans:list';

  Future<List<Plan>> getPlans({bool forceRefresh = false}) {
    return _cacheDatasource.fetchList<Plan>(
      cacheKey: _listCacheKey,
      forceRefresh: forceRefresh,
      remoteCall: () async {
        final plans = await _firestoreService.getCollection<Plan>(
          path: _collectionPath,
          fromJson: Plan.fromJson,
        );
        await _cacheDatasource.cacheMany<Plan>(
          collection: _collectionPath,
          models: plans,
        );
        return plans;
      },
    );
  }

  Future<void> createPlan(Plan plan) async {
    await _firestoreService.setDocument(
      path: '$_collectionPath/${plan.id}',
      data: plan.toFirestore(),
    );
    await _cacheDatasource.cacheModel<Plan>(
      collection: _collectionPath,
      model: plan,
    );
    await _cacheDatasource.invalidateList(_listCacheKey);
  }

  Future<void> updatePlan(Plan plan) async {
    await _firestoreService.updateDocument(
      path: '$_collectionPath/${plan.id}',
      data: plan.toFirestore(),
    );
    await _cacheDatasource.cacheModel<Plan>(
      collection: _collectionPath,
      model: plan,
    );
    await _cacheDatasource.invalidateList(_listCacheKey);
  }

  Future<void> togglePlanStatus({
    required String planId,
    required bool isActive,
  }) async {
    await _firestoreService.updateDocument(
      path: '$_collectionPath/$planId',
      data: {'isActive': isActive},
    );

    final cached = await _cacheDatasource.getById<Plan>(
      collection: _collectionPath,
      id: planId,
    );

    if (cached != null) {
      await _cacheDatasource.cacheModel<Plan>(
        collection: _collectionPath,
        model: cached.copyWith(isActive: isActive),
      );
    }
    await _cacheDatasource.invalidateList(_listCacheKey);
  }
}

final planRemoteDataSourceProvider = Provider<PlanRemoteDataSource>((ref) {
  final firestore = ref.watch(firestoreServiceProvider);
  final cache = ref.watch(cacheDatasourceProvider);
  return PlanRemoteDataSource(firestore, cache);
});
