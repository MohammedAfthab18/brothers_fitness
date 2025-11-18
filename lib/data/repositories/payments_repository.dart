import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/local/cache_datasource.dart';
import '../datasources/remote/payment_remote_datasource.dart';
import '../models/payment/payment.dart';

class PaymentsRepository {
  PaymentsRepository({
    required PaymentRemoteDataSource remote,
    required CacheDatasource cache,
  }) : _remote = remote,
       _cache = cache;

  final PaymentRemoteDataSource _remote;
  final CacheDatasource _cache;

  static const _recentPaymentsKey = 'payments_recent';

  Future<List<Payment>> getPaymentsByMember(String memberId) {
    return _remote.getPaymentsByMember(memberId);
  }

  Future<List<Payment>> getRecentPayments() async {
    final payments = await _cache.fetchList<Payment>(
      cacheKey: _recentPaymentsKey,
      remoteCall: () => _remote.getRecentPayments(),
    );
    return payments;
  }

  Future<void> createPayment(Payment payment) async {
    await _remote.createPayment(payment);
    await _cache.invalidateList(_recentPaymentsKey);
  }

  Future<List<Payment>> getPendingPayments() {
    return _remote.getPendingPayments();
  }
}

final paymentsRepositoryProvider = Provider<PaymentsRepository>((ref) {
  final remote = ref.read(paymentRemoteDataSourceProvider);
  final cache = ref.read(cacheDatasourceProvider);
  return PaymentsRepository(remote: remote, cache: cache);
});
