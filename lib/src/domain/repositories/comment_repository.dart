import 'package:test_application/src/domain/entities/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>?> getCommentsList({required int postId});
  Future<Comment?> addComment({required Comment comment}); 
}