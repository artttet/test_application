import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/screens/posts_list/screen.dart';
import 'package:test_application/src/presentation/screens/posts_list/state.dart';

class PostsListPage extends Page {
  final int userId;
  PostsListPage({required this.userId}) : super(key: ValueKey('Posts List Page - id:$userId'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (conext) => ProviderScope(
        overrides: [
          PostsListState.userIdProvider.overrideWithValue(userId)
        ],
        child: const PostsListScreen()
      )
    );
  }
}