import 'package:domain_core/src/entities/album.dart';

abstract class AlbumRepository {
  Future<List<Album>?> fetchAlbumsList({required int userId});
  Future<String?> fetchAlbumPreview({required int albumId});
}