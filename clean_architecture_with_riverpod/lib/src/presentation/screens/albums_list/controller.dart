import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/dependecies/repository_module.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack_item.dart';
import 'package:test_application/src/presentation/screens/albums_list/presenter.dart';
import 'package:test_application/src/presentation/screens/albums_list/state.dart';

final albumsListControllerProvider = Provider<AlbumsListController>((ref) =>
  AlbumsListController(read: ref.read));

class AlbumsListController {
  final Reader read;
  final AlbumsListPresenter _albumsListPresenter;

  AlbumsListController({required this.read})
      : _albumsListPresenter = AlbumsListPresenter(
          RepositoryModule.albumRepository()!
        );

  void onAlbumListTilePressed({required int id}) {
    read(mainNavigationStackProvider).push(
      MainNavigationStackItem.albumsDetails(albumId: id)
    );
  }

  Future getAlbumsList({required int userId, required bool isPreview}) async {
    final albumsList = read(AlbumsListState.albumsListProvider);
    final receivedAlbumsList = await _albumsListPresenter.getAlbumsList(userId: userId, isPreview: isPreview);
    receivedAlbumsList?.sort((a, b) => a.id.compareTo(b.id));
    albumsList.state = receivedAlbumsList;
  }

  void updateAlbumsList({required int userId, required bool isPreview}) async {
    final albumsList = read(AlbumsListState.albumsListProvider);
    albumsList.state = [];
    await getAlbumsList(userId: userId, isPreview: isPreview);
  }
}