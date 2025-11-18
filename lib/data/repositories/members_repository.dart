import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../datasources/local/cache_datasource.dart';
import '../datasources/remote/member_remote_datasource.dart';
import '../models/member/member.dart';

class MembersRepository {
  MembersRepository({
    required MemberRemoteDataSource remote,
    required CacheDatasource cache,
  }) : _remote = remote,
       _cache = cache;

  final MemberRemoteDataSource _remote;
  final CacheDatasource _cache;

  static const _membersListKey = 'members';

  Future<Member?> getMember(String id) async {
    final cacheKey = _memberCacheKey(id);
    final cached = await _cache.loadModelByKey<Member>(cacheKey);
    if (cached != null) {
      return cached;
    }

    final member = await _remote.getMemberById(id, forceRefresh: true);
    if (member != null) {
      await _cache.saveModelByKey<Member>(cacheKey, member);
    }
    return member;
  }

  Future<List<Member>> getAllMembers() async {
    final members = await _cache.fetchList<Member>(
      cacheKey: _membersListKey,
      remoteCall: () => _remote.getMembers(),
    );
    await _cacheIndividuals(members);
    members.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return members;
  }

  Future<void> createMember(Member member) async {
    await _remote.createMember(member);
    await _cache.saveModelByKey<Member>(_memberCacheKey(member.id), member);
    await _cache.invalidateList(_membersListKey);
  }

  Future<void> updateMember(Member member) async {
    await _remote.updateMember(member);
    await _cache.saveModelByKey<Member>(_memberCacheKey(member.id), member);
    await _cache.invalidateList(_membersListKey);
  }

  Future<void> deleteMember(String id) async {
    await _remote.deleteMember(id);
    await _cache.removeByKey(_memberCacheKey(id));
    await _cache.invalidateList(_membersListKey);
  }

  Future<List<Member>> searchMembers(String query) async {
    final normalized = query.trim().toLowerCase();
    final members = await _cache.fetchList<Member>(
      cacheKey: _membersListKey,
      remoteCall: () => _remote.getMembers(),
    );
    if (normalized.isEmpty) {
      return members;
    }

    return members.where((member) {
      final haystack = [
        member.fullName,
        member.phone,
        member.whatsappNumber,
      ].map((value) => value.toLowerCase());
      return haystack.any((value) => value.contains(normalized));
    }).toList();
  }

  Future<void> _cacheIndividuals(List<Member> members) async {
    await Future.wait(
      members.map(
        (member) =>
            _cache.saveModelByKey<Member>(_memberCacheKey(member.id), member),
      ),
    );
  }

  String _memberCacheKey(String id) => 'member_$id';
}

final membersRepositoryProvider = Provider<MembersRepository>((ref) {
  final remote = ref.read(memberRemoteDataSourceProvider);
  final cache = ref.read(cacheDatasourceProvider);
  return MembersRepository(remote: remote, cache: cache);
});
