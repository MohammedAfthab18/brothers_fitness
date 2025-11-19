import 'package:flutter_riverpod/flutter_riverpod.dart';

enum MemberStatusFilter { all, active, expiring, expired }

final memberStatusFilterProvider =
    NotifierProvider.autoDispose<MemberStatusFilterNotifier,
        MemberStatusFilter>(
  MemberStatusFilterNotifier.new,
);

class MemberStatusFilterNotifier extends Notifier<MemberStatusFilter> {
  @override
  MemberStatusFilter build() => MemberStatusFilter.all;

  void setFilter(MemberStatusFilter filter) {
    state = filter;
  }
}