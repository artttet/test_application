import 'package:test_application/src/domain/entities/post.dart';
import 'package:test_application/src/domain/repositories/post_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetPostUseCase extends UseCase<Future<Post?>, GetPostUseCaseParams> {
  final PostRepository _postRepository;
  GetPostUseCase(this._postRepository);

  @override
  Future<Post?> execute({GetPostUseCaseParams? params}) async {
    if (params == null) return null;
    else return await _postRepository.getPost(id: params.id);
  }
}

class GetPostUseCaseParams extends UseCaseParams {
  final int id;
  GetPostUseCaseParams({required this.id});
}