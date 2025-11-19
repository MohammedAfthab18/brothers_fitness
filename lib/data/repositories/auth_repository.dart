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
    try {
      // First, authenticate with Firebase Auth
      final credential = await _authService.signInWithEmailPassword(
        email: email,
        password: password,
      );
      
      final firebaseUser = credential.user ?? _authService.currentUser;
      if (firebaseUser == null) {
        throw Exception('Authentication failed - no user returned');
      }

      // Then sync with Firestore
      return await _syncWithFirestore(firebaseUser);
    } catch (e) {
      // Re-throw with more context
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> logout() => _authService.signOut();

  Stream<AppUser?> watchUser() {
    return _authService.authStateStream.asyncMap((firebaseUser) async {
      if (firebaseUser == null) {
        return null;
      }
      try {
        return await _syncWithFirestore(firebaseUser);
      } catch (e) {
        // Log error but don't break the stream
        print('Error syncing user: $e');
        return _buildUser(firebaseUser);
      }
    });
  }

  Future<AppUser?> getCurrentUser() async {
    final firebaseUser = _authService.currentUser;
    if (firebaseUser == null) {
      return null;
    }
    try {
      return await _syncWithFirestore(firebaseUser);
    } catch (e) {
      print('Error getting current user: $e');
      return _buildUser(firebaseUser);
    }
  }

  Future<void> refreshToken() async {
    await _authService.refreshIdToken();
  }

  Future<AppUser> _syncWithFirestore(User firebaseUser) async {
    try {
      // Try to fetch existing user
      final existing = await _fetchUser(firebaseUser.uid);
      if (existing != null) {
        return existing;
      }
    } catch (e) {
      print('Error fetching user from Firestore: $e');
    }

    // If user doesn't exist or fetch failed, create/update user document
    try {
      final user = _buildUser(firebaseUser);
      await _firestoreService.setDocument(
        path: 'users/${firebaseUser.uid}',
        data: user.toFirestore(),
        merge: true,
      );
      return user;
    } catch (e) {
      print('Error creating user in Firestore: $e');
      // Return user even if Firestore write fails (offline mode)
      return _buildUser(firebaseUser);
    }
  }

  Future<AppUser?> _fetchUser(String uid) async {
    try {
      return await _firestoreService.getDocument<AppUser>(
        path: 'users/$uid',
        fromJson: (json) => AppUser.fromJson(json),
        forceRefresh: false, // Use cache first
      );
    } catch (e) {
      print('Fetch user error: $e');
      return null;
    }
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