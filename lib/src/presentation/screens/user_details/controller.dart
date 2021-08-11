import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/dependecies/repository_module.dart';
import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/entities/user.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack_item.dart';
import 'package:test_application/src/presentation/screens/user_details/presenter.dart';
import 'package:test_application/src/presentation/screens/user_details/state.dart';

final userDetailsControllerProvider = Provider<UserDetailsController>((ref)
    => UserDetailsController(read: ref.read)
); 

class UserDetailsController {
  final Reader read;
  final UserDetailsPresenter userDetailsPresenter;

  UserDetailsController({required this.read})
      : userDetailsPresenter = UserDetailsPresenter(
          RepositoryModule.userRepository()!,
          RepositoryModule.postRepository()!,
          RepositoryModule.albumRepository()!,
          RepositoryModule.photoRepository()!
        );

  void goToPostsListScreen({required int userId}) {
    read(mainNavigationStackProvider).push(
      MainNavigationStackItem.postsList(userId: userId)
    );
  }

  void goToAlbumsListScreen({required int userId}) {
    read(mainNavigationStackProvider).push(
      MainNavigationStackItem.albumsList(userId: userId)
    );
  }

  Future getUser({required int id}) async {
    final user = read(UserDetailsState.userProvider);
    user.state = await userDetailsPresenter.getUser(id: id);
  }

  void updateUser({required int id}) async {
    final user = read(UserDetailsState.userProvider);
    user.state = UserEmpty();
    await getUser(id: id);
  }

  Future getPostsList({required int userId, required bool isPreview}) async {
    final postsList = read(UserDetailsState.postsListProvider);
    postsList.state = await userDetailsPresenter.getPostsList(userId: userId, isPreview: isPreview);
  }

  void updatePostsList({required int userId, required bool isPreview}) async {
    final postsList = read(UserDetailsState.postsListProvider);
    postsList.state = [];
    await getPostsList(userId: userId, isPreview: isPreview);
  }

  Future getAlbumsList({required int userId, required bool isPreview}) async {
    final albumList = read(UserDetailsState.albumsListProvider);
    albumList.state = await userDetailsPresenter.getAlbumsList(userId: userId, isPreview: isPreview);
  }

  void updateAlbumsList({required int userId, required bool isPreview}) async {
    final albumList = read(UserDetailsState.albumsListProvider);
    albumList.state = [];
    await getAlbumsList(userId: userId, isPreview: isPreview);
  }

  Future<Photo?> getFirstPhoto({required int albumId}) async {
    return await userDetailsPresenter.getFirstPhoto(albumId: albumId);
  }
}