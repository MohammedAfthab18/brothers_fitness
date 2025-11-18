import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/exceptions.dart';
import '../../models/member/member.dart';
import '../../models/payment/payment.dart';
import '../../models/plan/plan.dart';
import '../../services/local/cache_service.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);
typedef JsonEncoder<T> = Map<String, dynamic> Function(T value);
typedef IdSelector<T> = String Function(T value);

class CacheAdapter<T> {
  const CacheAdapter({
    required this.fromJson,
    required this.toJson,
    required this.idSelector,
  });

  final JsonFactory<T> fromJson;
  final JsonEncoder<T> toJson;
  final IdSelector<T> idSelector;
}

class CacheDatasource {
  CacheDatasource(this._cacheService) {
    registerAdapter<Member>(
      CacheAdapter<Member>(
        fromJson: Member.fromJson,
        toJson: (member) => member.toJson(),
        idSelector: (member) => member.id,
      ),
    );

    registerAdapter<Plan>(
      CacheAdapter<Plan>(
        fromJson: Plan.fromJson,
        toJson: (plan) => plan.toJson(),
        idSelector: (plan) => plan.id,
      ),
    );

    registerAdapter<Payment>(
      CacheAdapter<Payment>(
        fromJson: Payment.fromJson,
        toJson: (payment) => payment.toJson(),
        idSelector: (payment) => payment.id,
      ),
    );
  }

  final CacheService _cacheService;
  final _adapters = <Type, CacheAdapter<dynamic>>{};

  Duration defaultTtl = const Duration(minutes: 5);

  void registerAdapter<T>(CacheAdapter<T> adapter) {
    _adapters[T] = adapter;
  }

  Future<T?> getById<T>({
    required String collection,
    required String id,
  }) async {
    final adapter = _adapterFor<T>();
    final cached = await _cacheService.load(_docKey(collection, id));
    if (cached == null) {
      return null;
    }
    return adapter.fromJson(cached);
  }

  Future<void> cacheModel<T>({
    required String collection,
    required T model,
    Duration? ttl,
  }) async {
    final adapter = _adapterFor<T>();
    await _cacheService.save(
      _docKey(collection, adapter.idSelector(model)),
      adapter.toJson(model),
      ttl: ttl ?? defaultTtl,
    );
  }

  Future<void> cacheMany<T>({
    required String collection,
    required Iterable<T> models,
    Duration? ttl,
  }) async {
    for (final model in models) {
      await cacheModel(collection: collection, model: model, ttl: ttl);
    }
  }

  Future<void> removeById(String collection, String id) async {
    await _cacheService.remove(_docKey(collection, id));
  }

  Future<List<T>> fetchList<T>({
    required String cacheKey,
    required Future<List<T>> Function() remoteCall,
    Duration? ttl,
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cachedList = await _loadList<T>(cacheKey);
      if (cachedList != null) {
        return cachedList;
      }
    }

    final remoteItems = await remoteCall();
    await _cacheList(cacheKey, remoteItems, ttl: ttl ?? defaultTtl);
    return remoteItems;
  }

  Future<List<T>?> _loadList<T>(String cacheKey) async {
    final adapter = _adapterFor<T>();
    final cached = await _cacheService.load(_listKey(cacheKey));
    if (cached == null) {
      return null;
    }
    final items = (cached['items'] as List?)?.cast<Map<String, dynamic>>();
    if (items == null) {
      return null;
    }
    return items.map(adapter.fromJson).toList();
  }

  Future<void> _cacheList<T>(
    String cacheKey,
    Iterable<T> models, {
    Duration? ttl,
  }) async {
    final adapter = _adapterFor<T>();
    await _cacheService.save(_listKey(cacheKey), {
      'items': models.map(adapter.toJson).toList(),
    }, ttl: ttl ?? defaultTtl);
  }

  CacheAdapter<T> _adapterFor<T>() {
    final adapter = _adapters[T];
    if (adapter == null) {
      throw const AppException(message: 'Cache adapter missing');
    }
    return adapter as CacheAdapter<T>;
  }

  String _docKey(String collection, String id) => '$collection:$id';
  String _listKey(String cacheKey) => 'list:$cacheKey';

  Future<void> invalidateList(String cacheKey) async {
    await _cacheService.remove(_listKey(cacheKey));
  }
}

final cacheDatasourceProvider = Provider<CacheDatasource>((ref) {
  final cacheService = ref.watch(cacheServiceProvider);
  return CacheDatasource(cacheService);
});
