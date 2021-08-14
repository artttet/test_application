import 'package:test_application/src/data/api/models/api_album.dart';
import 'package:test_application/src/domain/entities/album.dart';

class AlbumMapper {
  static Album fromApi(ApiAlbum apiAlbum) => Album(
    userId: apiAlbum.userId,
    id: apiAlbum.id,
    title: apiAlbum.title
  );
}