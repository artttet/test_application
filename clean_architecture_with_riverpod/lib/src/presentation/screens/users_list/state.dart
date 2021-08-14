import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/user_short.dart';

class UsersListState {
  static final currentUserShortProvider = ScopedProvider<UserShort>((ref) => throw UnimplementedError());
  static final currentUserShortListProvider = ScopedProvider<List<UserShort>>((ref) => throw UnimplementedError());

  static final userShortListProvider = StateProvider<List<UserShort>?>((ref) {
    return [];
  });
}