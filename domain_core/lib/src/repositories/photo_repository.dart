import 'package:domain_core/src/entities/photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>?> fetchPhotosList({required int albumId});
  Photo fetchAlbumPreview({required int albumId});
}