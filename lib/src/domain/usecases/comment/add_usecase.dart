import 'package:test_application/src/domain/entities/comment.dart';
import 'package:test_application/src/domain/repositories/comment_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class AddCommentUseCase extends UseCase<Future<Comment?>, AddCommentUseCaseParams> {
  final CommentRepository _commentRepository;
  AddCommentUseCase(this._commentRepository);

  @override
  Future<Comment?> execute({AddCommentUseCaseParams? params}) async {
    if (params != null) {
      return await _commentRepository.addComment(comment: params.comment);
    } else return null;
  }
}

class AddCommentUseCaseParams extends UseCaseParams{
  final Comment comment;
  AddCommentUseCaseParams({required this.comment});
}