import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/screens/post_details/screen.dart';
import 'package:test_application/src/presentation/screens/post_details/state.dart';

class PostDetailsPage extends Page {
  final int postId;
  PostDetailsPage({required this.postId}) : super(key: ValueKey('Post Details Page - id:$postId'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (conext) => ProviderScope(
        overrides: [
          PostDetailsState.postIdProvider.overrideWithValue(postId)
        ],
        child: const PostDetailsScreen()
      )
    );
  }
}