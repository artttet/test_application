import 'package:test_application/src/data/api/api_util.dart';
import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/repositories/photo_repository.dart';

class PhotoDataRepository extends PhotoRepository {
  final ApiUtil _apiUtil;
  PhotoDataRepository(this._apiUtil);

  @override
  Future<Photo?> getFirstPhoto({required int albumId}) async {
    return await _apiUtil.getFirstPhoto(albumId: albumId); 
  }

  @override
  Future<List<Photo>?> getPhotosList({required int albumId}) async{
    return await _apiUtil.getPhotosList(albumId: albumId);
  }
}