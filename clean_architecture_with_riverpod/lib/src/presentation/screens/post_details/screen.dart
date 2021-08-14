import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/post_details/controller.dart';
import 'package:test_application/src/presentation/screens/post_details/state.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.comments),
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final controller = watch(postDetailsControllerProvider);
          final postId = watch(PostDetailsState.postIdProvider);

          return FutureBuilder(
            future: controller.getCommentsList(postId: postId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const _Content();
              } else {
                return const _Loading();
              }
            }
          );
        },
      )
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final commentsList = watch(PostDetailsState.commentsListProvider).state;

    if (commentsList != null) {
      if (commentsList.isNotEmpty) {
        return ProviderScope(
          overrides: [
            PostDetailsState.currentCommentsListProvider.overrideWithValue(commentsList)
          ],
          child: const Center(
            child: const _CommentsList() 
          ),
        );
      } else {
        return const _Loading();
      }   
    } else {
      return const _CommentsNotFound();
    } 
  }
}

class _Loading extends StatelessWidget {
  const _Loading();
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(
        color: Colors.purple,
      ),
    );
  }
}

class _CommentsNotFound extends StatelessWidget {
  const _CommentsNotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.commentsNotFound,
            style: theme.textTheme.headline5?.copyWith(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0,),
          Consumer(
            builder: (context, watch, _) {
              final controller = watch(postDetailsControllerProvider);
              final postId = watch(PostDetailsState.postIdProvider);

              return MaterialButton(
                height: 38.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                colorBrightness: Brightness.dark,
                child: Text(AppStrings.update),
                onPressed: () => controller.updateCommentsList(postId: postId)
              );
            }
          )
        ],
      ),
    );
  }
}

class _CommentsList extends ConsumerWidget {
  const _CommentsList();

  @override
  Widget build(BuildContext context, watch) {
    final currentCommentsList = watch(PostDetailsState.currentCommentsListProvider);

    final itemCount = currentCommentsList.length + 1;
    return ListView.separated(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        if (index != itemCount - 1) {
          return ProviderScope(
            overrides: [
              PostDetailsState.currentCommentProvider.overrideWithValue(currentCommentsList[index])
            ],
            child: const _CommentsListTile()
          );
        } else {
          return const _AddCommentButton();
        }
      },
      separatorBuilder: (context, index) {
        if (index != itemCount - 2) {
          return const Divider(height: 0.0);
        } else {
          return const SizedBox(height: 12.0);
        }
      } ,
    );
  }
}

class _CommentsListTile extends StatelessWidget {
  const _CommentsListTile();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Consumer(
        builder: (context, watch, _) {
          final currentComment = watch(PostDetailsState.currentCommentProvider);

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(currentComment.name, style: textTheme.subtitle2,),
              const SizedBox(height: 2.0,),
              Text(currentComment.email, style: textTheme.bodyText2?.copyWith(color: Colors.grey),),
              const SizedBox(height: 8.0,),
              Text(currentComment.body, style: textTheme.bodyText1,),
            ],
          );
        }
      ),
    );
  }
}

class _AddCommentButton extends ConsumerWidget {
  const _AddCommentButton();

  @override
  Widget build(BuildContext context, watch) {
    final controller = watch(postDetailsControllerProvider);
    final postId = watch(PostDetailsState.postIdProvider);

    return MaterialButton(
      elevation: 0,
      height: 50.0,
      child: const Text(AppStrings.addComment),
      onPressed: () => controller.addComment(context, postId: postId)
    );
  }
}
