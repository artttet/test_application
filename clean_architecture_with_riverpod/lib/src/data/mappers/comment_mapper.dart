import 'package:test_application/src/data/api/models/api_comment.dart';
import 'package:test_application/src/domain/entities/comment.dart';

class CommentMapper {
  static Comment fromApi(ApiComment apiComment) => Comment(
    postId: apiComment.postId,
    id: apiComment.id,
    name: apiComment.name,
    email: apiComment.email,
    body: apiComment.body
  );

  static ApiComment fromEntity(Comment comment) => ApiComment(
    postId: comment.postId,
    id: comment.id ?? null,
    name: comment.name,
    email: comment.email,
    body: comment.body
  );
}