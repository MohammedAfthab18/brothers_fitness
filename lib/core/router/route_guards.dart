import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/providers/auth_state_provider.dart';
import '../constants/route_constants.dart';

/// Simple guard widget that redirects unauthenticated users to the login page.
class AuthGuard extends ConsumerWidget {
  const AuthGuard({super.key, required this.builder});

  final Widget Function(BuildContext context, WidgetRef ref) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.go(RouteConstants.login);
            }
          });
          return const _AuthLoading();
        }
        return builder(context, ref);
      },
      loading: () => const _AuthLoading(),
      error: (error, stackTrace) => Center(
        child: Text(
          'Authentication error: ${error.toString()}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _AuthLoading extends StatelessWidget {
  const _AuthLoading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}