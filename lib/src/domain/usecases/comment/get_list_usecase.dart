import 'package:test_application/src/domain/entities/comment.dart';
import 'package:test_application/src/domain/repositories/comment_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetCommentsListUseCase extends UseCase<Future<List<Comment>?>, GetCommentsListUseCaseParams> {
  final CommentRepository _commentRepository;
  GetCommentsListUseCase(this._commentRepository);

  @override
  Future<List<Comment>?> execute({GetCommentsListUseCaseParams? params}) async {
    if (params != null) {
      return await _commentRepository.getCommentsList(postId: params.postId);
    } else return null;
  }
}

class GetCommentsListUseCaseParams extends UseCaseParams{
  final int postId;
  GetCommentsListUseCaseParams({required this.postId});
}