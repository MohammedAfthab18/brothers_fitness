import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user/app_user.dart';
import '../services/firebase/auth_service.dart';

class AuthRepository {
  AuthRepository(this._authService);

  final AuthService _authService;

  Future<AppUser?> login(String email, String password) async {
    final credential = await _authService.signInWithEmailPassword(
      email: email,
      password: password,
    );
    return _mapUser(credential.user ?? _authService.currentUser);
  }

  Future<void> logout() => _authService.signOut();

  Stream<AppUser?> watchUser() {
    return _authService.authStateStream.map(_mapUser);
  }

  Future<AppUser?> getCurrentUser() async {
    return _mapUser(_authService.currentUser);
  }

  Future<void> refreshToken() async {
    await _authService.refreshIdToken();
  }

  AppUser? _mapUser(User? firebaseUser) {
    if (firebaseUser == null) {
      return null;
    }
    final now = DateTime.now();
    final createdAt = firebaseUser.metadata.creationTime ?? now;
    final updatedAt = firebaseUser.metadata.lastSignInTime ?? now;
    return AppUser(
      id: firebaseUser.uid,
      displayName: firebaseUser.displayName ?? firebaseUser.email ?? 'Admin',
      email: firebaseUser.email ?? '',
      role: 'admin',
      permissions: const <String>[],
      photoBase64: null,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastSyncedAt: updatedAt,
      isSynced: true,
    );
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthRepository(authService);
});
