import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/exceptions.dart';

class AuthService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  StreamSubscription<User?>? _tokenSubscription;

  Stream<User?> get userStream => _auth.userChanges();

  Stream<User?> get authStateStream => _auth.authStateChanges();

  Stream<String?> get idTokenStream =>
      _auth.idTokenChanges().asyncMap((user) => user?.getIdToken());

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    await _tokenSubscription?.cancel();
    _tokenSubscription = null;
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  Future<String?> refreshIdToken({bool forceRefresh = true}) async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }
    try {
      return user.getIdToken(forceRefresh);
    } on FirebaseAuthException catch (error, stackTrace) {
      throw AppException.fromFirebase(error, stackTrace);
    }
  }

  void attachTokenRefreshListener(
    Future<void> Function(String token)? onTokenRefreshed,
  ) {
    _tokenSubscription?.cancel();
    if (onTokenRefreshed == null) {
      return;
    }

    _tokenSubscription = _auth.idTokenChanges().listen((user) async {
      final token = await user?.getIdToken();
      if (token != null) {
        await onTokenRefreshed(token);
      }
    });
  }

  Future<void> dispose() async {
    await _tokenSubscription?.cancel();
    _tokenSubscription = null;
  }
}

final authServiceProvider = Provider<AuthService>((ref) {
  final service = AuthService();
  ref.onDispose(() {
    unawaited(service.dispose());
  });
  return service;
});
