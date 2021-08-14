import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/dependecies/repository_module.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack_item.dart';
import 'package:test_application/src/presentation/screens/posts_list/presenter.dart';
import 'package:test_application/src/presentation/screens/posts_list/state.dart';

final postsListControllerProvider = Provider<PostsListController>((ref) =>
  PostsListController(read: ref.read));

class PostsListController {
  final Reader read;
  final PostsListPresenter _postsListPresenter;

  PostsListController({required this.read})
      : _postsListPresenter = PostsListPresenter(
          RepositoryModule.postRepository()!
        );

  void onPostListTilePressed({required int id}) {
    read(mainNavigationStackProvider).push(
      MainNavigationStackItem.postDetails(postId: id)
    );
  }

  Future getPostsList({required int userId, required bool isPreview}) async {
    final postsList = read(PostsListState.postsListProvider);
    final receivedPostsList = await _postsListPresenter.getPostsList(userId: userId, isPreview: isPreview);
    receivedPostsList?.sort((a, b) => a.id.compareTo(b.id));
    postsList.state = receivedPostsList;
  }

  void updatePostsList({required int userId, required bool isPreview}) async {
    final postsList = read(PostsListState.postsListProvider);
    postsList.state = [];
    await getPostsList(userId: userId, isPreview: isPreview);
  }
}