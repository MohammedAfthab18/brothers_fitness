import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user/app_user.dart';
import '../services/firebase/auth_service.dart';
import '../services/firebase/firestore_service.dart';

class AuthRepository {
  AuthRepository(this._authService, this._firestoreService);

  final AuthService _authService;
  final FirestoreService _firestoreService;

  Future<AppUser?> login(String email, String password) async {
    final credential = await _authService.signInWithEmailPassword(
      email: email,
      password: password,
    );
    final firebaseUser = credential.user ?? _authService.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return _syncWithFirestore(firebaseUser);
  }

  Future<void> logout() => _authService.signOut();

  Stream<AppUser?> watchUser() {
    return _authService.authStateStream.asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }
      return _syncWithFirestore(firebaseUser);
    });
  }

  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = _authService.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    return _syncWithFirestore(firebaseUser);
  }

  Future<void> refreshToken() async {
    await _authService.refreshIdToken();
  }

  Future<AppUser> _syncWithFirestore(User firebaseUser) async {
    final existing = await _fetchUser(firebaseUser.uid);
    if (existing != null) {
      return existing;
    }
    final user = _buildUser(firebaseUser);
    await _firestoreService.setDocument(
      path: 'users/${firebaseUser.uid}',
      data: user.toFirestore(),
      merge: true,
    );
    return user;
  }

  Future<AppUser?> _fetchUser(String uid) {
    return _firestoreService.getDocument<AppUser>(
      path: 'users/$uid',
      fromJson: (json) => AppUser.fromJson(json),
    );
  }

  AppUser _buildUser(User firebaseUser) {
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
  final firestoreService = ref.read(firestoreServiceProvider);
  return AuthRepository(authService, firestoreService);
});
