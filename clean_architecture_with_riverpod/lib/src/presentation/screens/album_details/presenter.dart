import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/repositories/photo_repository.dart';
import 'package:test_application/src/domain/usecases/photo/get_list_usecase.dart';

class AlbumDetailsPresenter {
  GetPhotosListUseCase _getPhotosListUseCase;
  AlbumDetailsPresenter(PhotoRepository photoRepository)
      : _getPhotosListUseCase = GetPhotosListUseCase(photoRepository);

  Future<List<Photo>?> getPhotosList({required int albumId}) async {
    final params = GetPhotosListUseCaseParams(albumId: albumId);
    return await _getPhotosListUseCase.execute(params: params);
  }
}