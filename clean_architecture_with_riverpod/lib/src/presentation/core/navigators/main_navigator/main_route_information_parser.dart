import 'package:flutter/widgets.dart';

import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack_item.dart';

class MainRouteInformationParser extends RouteInformationParser<MainNavigationStack> {
  
  // /users/1/posts/2
  // /users/3/albums/4
  @override
  Future<MainNavigationStack> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    final items = <MainNavigationStackItem>[];
    for (var i = 0, j = 1; i < uri.pathSegments.length && j < uri.pathSegments.length; i += 2, j += 2 ) {
      final key = uri.pathSegments[i];
      final value = uri.pathSegments[j];
      
      int currentUserId = -1;

      switch (key) {
        case _Keys.usersList:
          if (value.isEmpty) {
            items.add(MainNavigationStackItem.usersList());
          } else {
            final userId = int.tryParse(value);
            if (userId != null) {
              currentUserId = userId;
              items.add(MainNavigationStackItem.userDetails(userId: userId));
            } 
            else items.add(MainNavigationStackItem.notFound());
          }
          break;
        case _Keys.postsList:
          if (value.isEmpty) {
            if (currentUserId != -1) {
              items.add(MainNavigationStackItem.postsList(userId: currentUserId));
            }
          } else {
            final postId = int.tryParse(value);
            if (postId != null) {
              items.add(MainNavigationStackItem.postDetails(postId: postId));
            }
            else items.add(MainNavigationStackItem.notFound());
          }
          break;
        case _Keys.albumsList:
          if (value.isEmpty) {
            if (currentUserId != -1) {
              items.add(MainNavigationStackItem.albumsList(userId: currentUserId));
            }
          } else {
            final albumId = int.tryParse(value);
            if (albumId != null) {
              items.add(MainNavigationStackItem.albumsDetails(albumId: albumId));
            }
            else items.add(MainNavigationStackItem.notFound());
          }
          break;
      }
    }

    if (items.isEmpty || items.first is! MainNavigationStackItemUsersList) {
      final fallback = MainNavigationStackItem.usersList();
      if (items.isNotEmpty && items.first is MainNavigationStackItemNotFound) {
        items[0] = fallback;
      } else {
        items.insert(0, fallback);
      }
    }

    return MainNavigationStack(items);
  }

  @override
  RouteInformation restoreRouteInformation(MainNavigationStack configuration) {
    final location = configuration.items.fold<String>("", (previousValue, element) {
      return previousValue +
        element.when(
          onNotFound: () => '/${_Keys.notFound}',
          onUsersList: () => '/${_Keys.usersList}',
          onUserDetails: (userId) => '/$userId',
          onPostsList: (userId) => '/${_Keys.postsList}',
          onPostDetails: (postId) => '/$postId',
          onAlbumsList: (userId) => '/${_Keys.albumsList}',
          onAlbumDetails: (albumId) => '/$albumId'
        );
    });
    
    return RouteInformation(location: location);
  }
}

class _Keys {
  static const String notFound = 'notFound';
  static const String usersList = 'users';
  static const String postsList = 'posts';
  static const String albumsList = 'albums';
}