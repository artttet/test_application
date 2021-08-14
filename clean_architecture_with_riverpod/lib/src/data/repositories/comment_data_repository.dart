import 'package:test_application/src/data/api/api_util.dart';
import 'package:test_application/src/domain/entities/comment.dart';
import 'package:test_application/src/domain/repositories/comment_repository.dart';

class CommentDataRepository extends CommentRepository {
  final ApiUtil _apiUtil;
  CommentDataRepository(this._apiUtil);

  @override
  Future<Comment?> addComment({required Comment comment}) async {
    return await _apiUtil.addComment(comment: comment); 
  }

  @override
  Future<List<Comment>?> getCommentsList({required int postId}) async {
    return await _apiUtil.getCommentsList(postId: postId);
  }
}