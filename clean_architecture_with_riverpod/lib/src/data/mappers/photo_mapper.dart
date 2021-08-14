import 'package:test_application/src/data/api/models/api_photo.dart';
import 'package:test_application/src/domain/entities/photo.dart';

class PhotoMapper {
  static Photo fromApi(ApiPhoto apiPhoto) => Photo(
    albumId: apiPhoto.albumId,
    id: apiPhoto.albumId,
    title: apiPhoto.title,
    url: apiPhoto.url,
    thumbnailUrl: apiPhoto.thumbnailUrl,
  );
}