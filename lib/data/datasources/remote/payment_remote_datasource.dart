import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/payment/payment.dart';
import '../../services/firebase/firestore_service.dart';

class PaymentRemoteDataSource {
  PaymentRemoteDataSource(this._firestoreService);

  final FirestoreService _firestoreService;

  static const _collectionPath = 'payments';

  Future<void> createPayment(Payment payment) {
    return _firestoreService.setDocument(
      path: '$_collectionPath/${payment.id}',
      data: payment.toFirestore(),
    );
  }

  Future<List<Payment>> getPaymentsByMember(String memberId) {
    return _firestoreService.getCollection<Payment>(
      path: _collectionPath,
      fromJson: Payment.fromJson,
      queryBuilder: (collection) => collection
          .where('memberId', isEqualTo: memberId)
          .orderBy('paidAt', descending: true),
    );
  }

  Future<List<Payment>> getRecentPayments({int limit = 20}) {
    return _firestoreService.getCollection<Payment>(
      path: _collectionPath,
      fromJson: Payment.fromJson,
      queryBuilder: (collection) =>
          collection.orderBy('paidAt', descending: true).limit(limit),
    );
  }

  Future<List<Payment>> getPendingPayments() {
    return _firestoreService.getCollection<Payment>(
      path: _collectionPath,
      fromJson: Payment.fromJson,
      queryBuilder: (collection) => collection
          .where('status', isEqualTo: 'pending')
          .orderBy('expiryDate'),
    );
  }
}

final paymentRemoteDataSourceProvider = Provider<PaymentRemoteDataSource>((
  ref,
) {
  final firestore = ref.watch(firestoreServiceProvider);
  return PaymentRemoteDataSource(firestore);
});
