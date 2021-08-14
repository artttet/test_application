import 'package:test_application/src/domain/entities/post.dart';
import 'package:test_application/src/domain/repositories/post_repository.dart';
import 'package:test_application/src/domain/usecases/post/get_list_usecase.dart';

class PostsListPresenter {
  final GetPostsListUseCase _getPostsListUseCase;

  PostsListPresenter(PostRepository postRepository)
    : _getPostsListUseCase = GetPostsListUseCase(postRepository);

  Future<List<Post>?> getPostsList({required int userId, required bool isPreview}) async {
    final params = GetPostsListUseCaseParams(userId: userId, isPreview: isPreview);
    return await _getPostsListUseCase.execute(params: params);
  }
}