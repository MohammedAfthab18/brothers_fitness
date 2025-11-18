import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/local/cache_datasource.dart';
import '../datasources/remote/plan_remote_datasource.dart';
import '../models/plan/plan.dart';

class PlansRepository {
  PlansRepository({
    required PlanRemoteDataSource remote,
    required CacheDatasource cache,
  }) : _remote = remote,
       _cache = cache;

  final PlanRemoteDataSource _remote;
  final CacheDatasource _cache;

  static const _plansListKey = 'plans';

  Future<List<Plan>> getPlans() async {
    final plans = await _cache.fetchList<Plan>(
      cacheKey: _plansListKey,
      remoteCall: () => _remote.getPlans(),
    );
    await _cachePlans(plans);
    plans.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return plans;
  }

  Future<void> createPlan(Plan plan) async {
    await _remote.createPlan(plan);
    await _cache.saveModelByKey<Plan>(_planCacheKey(plan.id), plan);
    await _cache.invalidateList(_plansListKey);
  }

  Future<void> updatePlan(Plan plan) async {
    await _remote.updatePlan(plan);
    await _cache.saveModelByKey<Plan>(_planCacheKey(plan.id), plan);
    await _cache.invalidateList(_plansListKey);
  }

  Future<void> togglePlanStatus(String planId, bool isActive) async {
    await _remote.togglePlanStatus(planId: planId, isActive: isActive);
    final cachedPlan = await _cache.loadModelByKey<Plan>(_planCacheKey(planId));
    if (cachedPlan != null) {
      await _cache.saveModelByKey<Plan>(
        _planCacheKey(planId),
        cachedPlan.copyWith(isActive: isActive),
      );
    }
    await _cache.invalidateList(_plansListKey);
  }

  Future<void> _cachePlans(List<Plan> plans) async {
    await Future.wait(
      plans.map(
        (plan) => _cache.saveModelByKey<Plan>(_planCacheKey(plan.id), plan),
      ),
    );
  }

  String _planCacheKey(String id) => 'plan_$id';
}

final plansRepositoryProvider = Provider<PlansRepository>((ref) {
  final remote = ref.read(planRemoteDataSourceProvider);
  final cache = ref.read(cacheDatasourceProvider);
  return PlansRepository(remote: remote, cache: cache);
});
