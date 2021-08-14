import 'package:flutter/widgets.dart';

import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack.dart';
import 'package:test_application/src/presentation/screens/album_details/page.dart';
import 'package:test_application/src/presentation/screens/albums_list/page.dart';
import 'package:test_application/src/presentation/screens/not_found/page.dart';
import 'package:test_application/src/presentation/screens/post_details/page.dart';
import 'package:test_application/src/presentation/screens/posts_list/page.dart';
import 'package:test_application/src/presentation/screens/user_details/page.dart';
import 'package:test_application/src/presentation/screens/users_list/page.dart';

class MainRouterDelegate extends RouterDelegate<MainNavigationStack> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final MainNavigationStack stack;

  MainRouterDelegate({required this.stack}) : super() {
    stack.addListener(notifyListeners);
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  MainNavigationStack get currentConfiguration => stack;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: _pages(),
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        stack.pop();
        return true;
      },
    );
  }

  List<Page> _pages() => stack.items
    .map((item) => item.when(
      onNotFound: () => NotFoundPage(),
      onUsersList: () => UsersListPage(),
      onUserDetails: (userId) => UserDetailsPage(userId: userId),
      onPostsList: (userId) => PostsListPage(userId: userId),
      onPostDetails: (postId) => PostDetailsPage(postId: postId),
      onAlbumsList: (userId) => AlbumsListPage(userId: userId),
      onAlbumDetails: (albumId) => AlbumDetailsPage(albumId: albumId),
    ))
    .toList();

  @override
  Future<void> setNewRoutePath(configuration) async {
    stack.items = configuration.items;
  }

  @override
  void dispose() {
    stack.removeListener(notifyListeners);
    super.dispose();
  }
}