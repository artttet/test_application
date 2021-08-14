import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/post.dart';

class PostsListState {
  static final userIdProvider = ScopedProvider<int>((ref) => throw UnimplementedError());
  static final currentPostsListProvider = ScopedProvider<List<Post>>((ref) => throw UnimplementedError());
  static final currentPost = ScopedProvider<Post>((ref) => throw UnimplementedError());

  static final postsListProvider = StateProvider<List<Post>?>((ref)
      => []);
}