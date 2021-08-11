import 'package:test_application/src/domain/entities/photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>?> getPhotosList({required int albumId});
  Future<Photo?> getFirstPhoto({required int albumId});
}