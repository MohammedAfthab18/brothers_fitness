import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/members/presentation/pages/add_edit_member_page.dart';
import '../../features/members/presentation/pages/member_details_page.dart';
import '../../features/members/presentation/pages/members_list_page.dart';
import '../../features/payments/presentation/pages/payments_list_page.dart';
import '../../features/plans/presentation/pages/plans_list_page.dart';
import '../../features/reminders/presentation/pages/reminders_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../constants/route_constants.dart';

/// App router configuration using go_router.
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteConstants.login,
    routes: [
      // Auth routes
      GoRoute(
        path: RouteConstants.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      // Dashboard
      GoRoute(
        path: RouteConstants.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      // Members routes
      GoRoute(
        path: RouteConstants.members,
        name: 'members',
        builder: (context, state) => const MembersListPage(),
        routes: [
          GoRoute(
            path: 'create',
            name: 'memberCreate',
            builder: (context, state) => const AddEditMemberPage(),
          ),
          GoRoute(
            path: ':id',
            name: 'memberDetail',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              return MemberDetailsPage(memberId: id);
            },
            routes: [
              GoRoute(
                path: 'edit',
                name: 'memberEdit',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  return AddEditMemberPage(memberId: id);
                },
              ),
            ],
          ),
        ],
      ),
      // Plans routes
      GoRoute(
        path: RouteConstants.plans,
        name: 'plans',
        builder: (context, state) => const PlansListPage(),
        routes: [
          GoRoute(
            path: 'create',
            name: 'planCreate',
            builder: (context, state) {
              // TODO: Create plan create page
              return const PlansListPage();
            },
          ),
          GoRoute(
            path: ':id/edit',
            name: 'planEdit',
            builder: (context, state) {
              // TODO: Create plan edit page
              return const PlansListPage();
            },
          ),
        ],
      ),
      // Payments routes
      GoRoute(
        path: RouteConstants.payments,
        name: 'payments',
        builder: (context, state) => const PaymentsListPage(),
        routes: [
          GoRoute(
            path: 'create',
            name: 'paymentCreate',
            builder: (context, state) {
              // TODO: Create payment create page
              return const PaymentsListPage();
            },
          ),
          GoRoute(
            path: ':id',
            name: 'paymentDetail',
            builder: (context, state) {
              // TODO: Create payment detail page
              return const PaymentsListPage();
            },
          ),
        ],
      ),
      // Reminders routes
      GoRoute(
        path: RouteConstants.reminders,
        name: 'reminders',
        builder: (context, state) => const RemindersPage(),
        routes: [
          GoRoute(
            path: 'create',
            name: 'reminderCreate',
            builder: (context, state) {
              // TODO: Create reminder create page
              return const RemindersPage();
            },
          ),
          GoRoute(
            path: ':id/edit',
            name: 'reminderEdit',
            builder: (context, state) {
              // TODO: Create reminder edit page
              return const RemindersPage();
            },
          ),
        ],
      ),
      // Settings routes
      GoRoute(
        path: RouteConstants.settings,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
});
