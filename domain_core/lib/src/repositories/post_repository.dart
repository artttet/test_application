import 'package:domain_core/src/entities/post.dart';

abstract class PostRepository {
  Future<List<Post>?> fetchPostsList({required int userId});
  Future<Post?> fetchPost({required int id}); 
}