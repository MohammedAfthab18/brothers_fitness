import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/member/member.dart';
import '../../../data/repositories/members_repository.dart';
import 'member_filters_provider.dart';
import 'member_search_provider.dart';

final membersListProvider =
    FutureProvider.autoDispose<List<Member>>((ref) async {
  final repository = ref.watch(membersRepositoryProvider);
  return repository.getAllMembers();
});

final filteredMembersProvider =
    Provider.autoDispose<AsyncValue<List<Member>>>((ref) {
  final membersAsync = ref.watch(membersListProvider);
  final query = ref.watch(memberSearchQueryProvider).trim().toLowerCase();
  final filter = ref.watch(memberStatusFilterProvider);

  return membersAsync.whenData((members) {
    return members.where((member) {
      final matchesQuery = query.isEmpty ||
          member.fullName.toLowerCase().contains(query) ||
          member.phone.toLowerCase().contains(query) ||
          member.whatsappNumber.toLowerCase().contains(query) ||
          member.planName.toLowerCase().contains(query);

      final statusValue = member.status.toLowerCase();
      final matchesStatus = switch (filter) {
        MemberStatusFilter.all => true,
        MemberStatusFilter.active => statusValue == 'active',
        MemberStatusFilter.expiring => statusValue == 'expiring',
        MemberStatusFilter.expired => statusValue == 'expired',
      };

      return matchesQuery && matchesStatus;
    }).toList();
  });
});