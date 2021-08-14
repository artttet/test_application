import 'package:test_application/src/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>?> getAlbums({required int userId, required bool isPreview});
}