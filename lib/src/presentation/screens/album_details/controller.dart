import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/dependecies/repository_module.dart';
import 'package:test_application/src/presentation/screens/album_details/presenter.dart';
import 'package:test_application/src/presentation/screens/album_details/state.dart';

final albumDetailsControllerProvider = Provider<AlbumDetailsController>((ref) 
    => AlbumDetailsController(read: ref.read));

class AlbumDetailsController {
  final Reader read;
  final AlbumDetailsPresenter _albumDetailsPresenter;
  AlbumDetailsController({required this.read})
      : _albumDetailsPresenter = AlbumDetailsPresenter(
        RepositoryModule.photoRepository()!
      );

  Future getPhotosList({required int albumId}) async {
    final photosList = read(AlbumDetailsState.photosListProvider);
    final receivedPhotosList = await _albumDetailsPresenter.getPhotosList(albumId: albumId);
    receivedPhotosList?.sort((a, b) => a.id.compareTo(b.id));
    photosList.state = receivedPhotosList;
  }

  void updatePhotosList({required int albumId}) async {
    final photosList = read(AlbumDetailsState.photosListProvider);
    photosList.state = [];
    await getPhotosList(albumId: albumId);
  }
}