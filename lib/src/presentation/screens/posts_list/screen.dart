import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/posts_list/controller.dart';
import 'package:test_application/src/presentation/screens/posts_list/state.dart';

class PostsListScreen extends StatelessWidget {
  const PostsListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.posts),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final controller = watch(postsListControllerProvider);
          final userId = watch(PostsListState.userIdProvider);

          return FutureBuilder(
            future: controller.getPostsList(userId: userId, isPreview: false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const _Content();
              } else {
                return const _Loading();
              }
            }
          );
        },
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final postsList = watch(PostsListState.postsListProvider).state;

    if (postsList != null) {
      if (postsList.isNotEmpty) {
        return ProviderScope(
          overrides: [
            PostsListState.currentPostsListProvider.overrideWithValue(postsList)
          ],
          child: const Center(
            child: const _PostsList()
          ),
        );
      } else {
        return const _Loading();
      }   
    } else {
      return const _PostsNotFound();
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
            style: theme.textTheme.headline5?.copyWith(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0,),
          Consumer(
            builder: (context, watch, _) {
              final controller = watch(postsListControllerProvider);
              final userId = watch(PostsListState.userIdProvider);

              return MaterialButton(
                height: 38.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                colorBrightness: Brightness.dark,
                child: Text(AppStrings.update),
                onPressed: () => controller.updatePostsList(userId: userId, isPreview: false)
              );
            }
          )
        ],
      ),
    );
  }
}

class _PostsList extends ConsumerWidget {
  const _PostsList();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final postsList = watch(PostsListState.currentPostsListProvider);

    return ListView.separated(
      itemCount: postsList.length,
      separatorBuilder: (context, index) => const Divider(height: 0.0,),
      itemBuilder: (context, index) {
        final post = postsList[index];

        return ProviderScope(
          overrides: [
            PostsListState.currentPost.overrideWithValue(post)
          ],
          child: const _PostsListTile()
        );
      }
    );
  }
}

class _PostsListTile extends ConsumerWidget {
  const _PostsListTile();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(postsListControllerProvider);
    final post = watch(PostsListState.currentPost);

    return ListTile(
      title: Text(post.title),
      subtitle: Text(post.body, maxLines: 1, overflow: TextOverflow.ellipsis,),
      onTap: () => controller.onPostListTilePressed(id: post.id),
    );
  }
}