import 'package:test_application/src/domain/entities/comment.dart';
import 'package:test_application/src/domain/repositories/comment_repository.dart';
import 'package:test_application/src/domain/usecases/comment/add_usecase.dart';
import 'package:test_application/src/domain/usecases/comment/get_list_usecase.dart';

class PostDetailsPresenter {
  GetCommentsListUseCase _getCommentsListUseCase;
  AddCommentUseCase _addCommentUseCase;

  PostDetailsPresenter(CommentRepository commentRepository)
      : _getCommentsListUseCase = GetCommentsListUseCase(commentRepository),
        _addCommentUseCase = AddCommentUseCase(commentRepository);

  Future<List<Comment>?> getCommentsList({required int postId}) async {
    final params = GetCommentsListUseCaseParams(postId: postId);
    return await _getCommentsListUseCase.execute(params: params); 
  }

  Future<Comment?> addComment({required Comment comment}) async {
    final params = AddCommentUseCaseParams(comment: comment);
    return await _addCommentUseCase.execute(params: params);
  }
}