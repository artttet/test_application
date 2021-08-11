import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/screens/albums_list/screen.dart';
import 'package:test_application/src/presentation/screens/albums_list/state.dart';

class AlbumsListPage extends Page {
  final int userId;
  AlbumsListPage({required this.userId}) : super(key: ValueKey('Albums List Page - id:$userId'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (conext) => ProviderScope(
        overrides: [
          AlbumsListState.userIdProvider.overrideWithValue(userId)
        ],
        child: const AlbumsListScreen()
      )
    );
  }
}