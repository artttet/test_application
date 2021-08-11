import 'package:test_application/src/domain/entities/album.dart';
import 'package:test_application/src/domain/repositories/album_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetAlbumsListUseCase extends UseCase<Future<List<Album>?>, GetAlbumsListUseCaseParams> {
  final AlbumRepository _albumRepository;
  GetAlbumsListUseCase(this._albumRepository);

  @override
  Future<List<Album>?> execute({GetAlbumsListUseCaseParams? params}) async {
    if (params == null) return null;
    else return await _albumRepository.getAlbums(userId: params.userId, isPreview: params.isPreview);
  }
}

class GetAlbumsListUseCaseParams extends UseCaseParams {
  final int userId;
  final bool isPreview;
  GetAlbumsListUseCaseParams({required this.userId, required this.isPreview});
}