import 'package:test_application/src/domain/entities/album.dart';
import 'package:test_application/src/domain/repositories/album_repository.dart';
import 'package:test_application/src/domain/usecases/album/get_list_usecase.dart';

class AlbumsListPresenter {
  final GetAlbumsListUseCase _getAlbumsListUseCase;

  AlbumsListPresenter(AlbumRepository albumRepository)
    : _getAlbumsListUseCase = GetAlbumsListUseCase(albumRepository);

  Future<List<Album>?> getAlbumsList({required int userId, required bool isPreview}) async {
    final params = GetAlbumsListUseCaseParams(userId: userId, isPreview: isPreview);
    return await _getAlbumsListUseCase.execute(params: params);
  }
}