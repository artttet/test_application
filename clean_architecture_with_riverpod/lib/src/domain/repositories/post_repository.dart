import 'package:test_application/src/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>?> getPostsList({required int userId, required bool isPreview});
  Future<Post?> getPost({required int id});
}