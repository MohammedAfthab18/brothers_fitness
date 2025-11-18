import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/payment/payment.dart';
import '../../services/firebase/firestore_service.dart';
import '../local/cache_datasource.dart';

class PaymentRemoteDataSource {
  PaymentRemoteDataSource(this._firestoreService, this._cacheDatasource);

  final FirestoreService _firestoreService;
  final CacheDatasource _cacheDatasource;

  static const _collectionPath = 'payments';
  static const _recentCacheKey = 'payments:recent';
  static const _pendingCacheKey = 'payments:pending';

  Future<void> createPayment(Payment payment) async {
    await _firestoreService.setDocument(
      path: '$_collectionPath/${payment.id}',
      data: payment.toFirestore(),
    );
    await _cacheDatasource.cacheModel<Payment>(
      collection: _collectionPath,
      model: payment,
    );
    await _cacheDatasource.invalidateList(_recentCacheKey);
    await _cacheDatasource.invalidateList(_pendingCacheKey);
    await _cacheDatasource.invalidateList(_memberCacheKey(payment.memberId));
  }

  Future<List<Payment>> getPaymentsByMember(
    String memberId, {
    bool forceRefresh = false,
  }) {
    final cacheKey = _memberCacheKey(memberId);
    return _cacheDatasource.fetchList<Payment>(
      cacheKey: cacheKey,
      forceRefresh: forceRefresh,
      remoteCall: () async {
        final payments = await _firestoreService.getCollection<Payment>(
          path: _collectionPath,
          fromJson: Payment.fromJson,
          queryBuilder: (collection) => collection
              .where('memberId', isEqualTo: memberId)
              .orderBy('paidAt', descending: true),
        );
        await _cacheDatasource.cacheMany<Payment>(
          collection: _collectionPath,
          models: payments,
        );
        return payments;
      },
    );
  }

  Future<List<Payment>> getRecentPayments({
    int limit = 20,
    bool forceRefresh = false,
  }) {
    return _cacheDatasource.fetchList<Payment>(
      cacheKey: _recentCacheKey,
      forceRefresh: forceRefresh,
      remoteCall: () async {
        final payments = await _firestoreService.getCollection<Payment>(
          path: _collectionPath,
          fromJson: Payment.fromJson,
          queryBuilder: (collection) =>
              collection.orderBy('paidAt', descending: true).limit(limit),
        );
        await _cacheDatasource.cacheMany<Payment>(
          collection: _collectionPath,
          models: payments,
        );
        return payments;
      },
    );
  }

  Future<List<Payment>> getPendingPayments({bool forceRefresh = false}) {
    return _cacheDatasource.fetchList<Payment>(
      cacheKey: _pendingCacheKey,
      forceRefresh: forceRefresh,
      remoteCall: () async {
        final payments = await _firestoreService.getCollection<Payment>(
          path: _collectionPath,
          fromJson: Payment.fromJson,
          queryBuilder: (collection) => collection
              .where('status', isEqualTo: 'pending')
              .orderBy('expiryDate'),
        );
        await _cacheDatasource.cacheMany<Payment>(
          collection: _collectionPath,
          models: payments,
        );
        return payments;
      },
    );
  }

  String _memberCacheKey(String memberId) => 'payments:member:$memberId';
}

final paymentRemoteDataSourceProvider = Provider<PaymentRemoteDataSource>((
  ref,
) {
  final firestore = ref.watch(firestoreServiceProvider);
  final cache = ref.watch(cacheDatasourceProvider);
  return PaymentRemoteDataSource(firestore, cache);
});
