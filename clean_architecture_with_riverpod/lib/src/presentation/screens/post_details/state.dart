import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/comment.dart';

class PostDetailsState {
  static final postIdProvider = ScopedProvider<int>((ref) => throw UnimplementedError());
  static final currentCommentsListProvider = ScopedProvider<List<Comment>>((ref) => throw UnimplementedError());
  static final currentCommentProvider = ScopedProvider<Comment>((ref) => throw UnimplementedError());

  static final commentsListProvider = StateProvider<List<Comment>?>((ref)
      => []);
  static final commentProvider = StateProvider((ref)
      => CommentEmpty());
}