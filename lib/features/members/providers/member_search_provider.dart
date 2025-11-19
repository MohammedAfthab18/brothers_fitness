import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberSearchQueryProvider =
    NotifierProvider.autoDispose<MemberSearchNotifier, String>(
  MemberSearchNotifier.new,
);

class MemberSearchNotifier extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String value) {
    state = value;
  }
}