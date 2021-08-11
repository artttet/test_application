import 'package:test_application/src/domain/entities/post.dart';
import 'package:test_application/src/domain/repositories/post_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetPostsListUseCase extends UseCase<Future<List<Post>?>, GetPostsListUseCaseParams> {
  final PostRepository _postRepository;
  GetPostsListUseCase(this._postRepository);

  @override
  Future<List<Post>?> execute({GetPostsListUseCaseParams? params}) async {
    if (params == null) return null;
    else return await _postRepository.getPostsList(userId: params.userId, isPreview: params.isPreview);
  }
}

class GetPostsListUseCaseParams extends UseCaseParams {
  final int userId;
  final bool isPreview;
  GetPostsListUseCaseParams({required this.userId, required this.isPreview});
}