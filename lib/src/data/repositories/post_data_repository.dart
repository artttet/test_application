import 'package:test_application/src/data/api/api_util.dart';
import 'package:test_application/src/domain/entities/post.dart';
import 'package:test_application/src/domain/repositories/post_repository.dart';

class PostDataRepository extends PostRepository {
  final ApiUtil _apiUtil;
  PostDataRepository(this._apiUtil);

  @override
  Future<List<Post>?> getPostsList({required int userId, required bool isPreview}) async {
    return await _apiUtil.getPostsList(userId: userId, isPreview: isPreview);
  }

  @override
  Future<Post?> getPost({required int id}) async {
    // return await _apiUtil.getPost();
  }
}