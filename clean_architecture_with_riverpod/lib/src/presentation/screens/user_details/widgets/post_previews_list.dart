import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/user_details/controller.dart';
import 'package:test_application/src/presentation/screens/user_details/state.dart';
import 'package:test_application/src/presentation/screens/user_details/widgets/loading.dart';

class PostPreviewsList extends StatelessWidget {
  const PostPreviewsList();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.posts.toUpperCase(), style: textTheme.subtitle2?.copyWith(color: Colors.grey),),
        const SizedBox(height: 8.0,),
        const _PostsCard(),
      ],
    );
  }
}

class _PostsCard extends ConsumerWidget {
  const _PostsCard();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(userDetailsControllerProvider);
    final userId = watch(UserDetailsState.userIdProvider);

    return FutureBuilder(
      future: controller.getPostsList(userId: userId, isPreview: true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer(
            builder: (context, watch, _) {
              final postsList = watch(UserDetailsState.postsListProvider).state;

              if (postsList == null) return const _PostsNotFound();

              if (postsList.isEmpty) {
                return const Loading();
              } else {
                return ProviderScope(
                  overrides: [
                    UserDetailsState.currentPostsList.overrideWithValue(postsList)
                  ],
                  child: const _PostsCardContent()
                );
              }
            }
          );
        }

        return const Loading();
      }
    );
  }
}

class _PostsNotFound extends StatelessWidget {
  const _PostsNotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.postsNotFound,
            style: theme.textTheme.headline6?.copyWith(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0,),
          Consumer(
            builder: (context, watch, _) {
              final controller = watch(userDetailsControllerProvider);
              final userId = watch(UserDetailsState.userIdProvider);

              return MaterialButton(
                height: 38.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                colorBrightness: Brightness.dark,
                child: Text(AppStrings.update),
                onPressed: () => controller.updatePostsList(userId: userId, isPreview: true)
              );
            }
          )
        ],
      ),
    );
  }
}

class _PostsCardContent extends ConsumerWidget {
  const _PostsCardContent();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(userDetailsControllerProvider);
    final userId = watch(UserDetailsState.userIdProvider);
    final currentPostsList = watch(UserDetailsState.currentPostsList);

    return Column(
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            children: currentPostsList.map((post) => Column(
              children: [
                ProviderScope(
                  overrides: [
                    UserDetailsState.currentPost.overrideWithValue(post)
                  ],
                  child: const _PostPreviewTile()
                ),
                if (currentPostsList.indexOf(post) != currentPostsList.length-1) Divider(height: 0.0,)
              ],
            )).toList(),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            child: const Text(AppStrings.more),
            onPressed: () => controller.goToPostsListScreen(userId: userId),
          ),
        )
      ],
    );
  }
}

class _PostPreviewTile extends ConsumerWidget {
  const _PostPreviewTile();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentPost = watch(UserDetailsState.currentPost);

    return  ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(currentPost.title),
      subtitle: Text(currentPost.body, maxLines: 1, overflow: TextOverflow.ellipsis),
    );
  }
}