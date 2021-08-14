import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/dependecies/repository_module.dart';
import 'package:test_application/src/domain/entities/comment.dart';
import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/post_details/presenter.dart';
import 'package:test_application/src/presentation/screens/post_details/state.dart';
import 'package:test_application/src/presentation/screens/post_details/widgets/dialog.dart';

final postDetailsControllerProvider = Provider<PostDetailsController>((ref)
    => PostDetailsController(read: ref.read));

class PostDetailsController {
  final Reader read;
  final PostDetailsPresenter _postDetailsPresenter;
  PostDetailsController({required this.read})
      : _postDetailsPresenter = PostDetailsPresenter(
          RepositoryModule.commentRepository()!
        );

  Future getCommentsList({required int postId}) async {
    final commentsList = read(PostDetailsState.commentsListProvider);
    final receivedCommentsList = await _postDetailsPresenter.getCommentsList(postId: postId);
    receivedCommentsList?.sort((a, b) => a.id!.compareTo(b.id!));
    commentsList.state = receivedCommentsList;
  }

  void updateCommentsList({required int postId}) async {
    final commentsList = read(PostDetailsState.commentsListProvider);
    commentsList.state = [];
    await getCommentsList(postId: postId);
  }

  Comment createComment({
    required int postId,
    required String name,
    required String email,
    required String body,
  }) => Comment(
    postId: postId,
    name: name,
    email: email,
    body: body
  );

  Future<void> addComment(BuildContext context, {required int postId}) async {
    final comment = await showDialog<Comment?>(
      context: context,
      builder: (context) {
        return AddCommentDialog(postId: postId,);
      }
    );
    if (comment != null) {
      await _addComment(context, postId: postId, comment: comment);
    }
  }

  Future<Comment?> _addComment(BuildContext context, {
    required int postId,
    required Comment comment
  }) async {
    final _comment = await _postDetailsPresenter.addComment(comment: comment);
    if (_comment != null) {
      updateCommentsList(postId: postId);
    } else {
      updateCommentsList(postId: postId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(AppStrings.commentWasNotSend),
          action: SnackBarAction(
            label: AppStrings.ok,
            onPressed: () {},
          ),
        )
      );
    }
  }
}