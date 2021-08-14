import 'package:domain_core/src/entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>?> fetchCommentsList({required int postId});
  Future<Comment?> addComment({required Comment comment});
}