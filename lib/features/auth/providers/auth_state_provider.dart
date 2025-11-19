import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/user/app_user.dart';
import '../../../data/repositories/auth_repository.dart';

final authStateProvider = StreamProvider<AppUser?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.watchUser();
});