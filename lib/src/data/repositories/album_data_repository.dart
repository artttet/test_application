import 'package:test_application/src/data/api/api_util.dart';
import 'package:test_application/src/domain/entities/album.dart';
import 'package:test_application/src/domain/repositories/album_repository.dart';

class AlbumDataRepository extends AlbumRepository {
  final ApiUtil _apiUtil;
  AlbumDataRepository(this._apiUtil);

  @override
  Future<List<Album>?> getAlbums({required int userId, required bool isPreview}) async {
    return await _apiUtil.getAlbumsList(userId: userId, isPreview: isPreview);
  }
}