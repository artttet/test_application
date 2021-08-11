import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/repositories/photo_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetFirstPhotoUseCase extends UseCase<Future<Photo?>, GetFirstPhotoUseCaseParams> {
  final PhotoRepository _photoRepository;
  GetFirstPhotoUseCase(this._photoRepository);
  
  @override
  Future<Photo?> execute({GetFirstPhotoUseCaseParams? params}) async {
    if (params != null) return await _photoRepository.getFirstPhoto(albumId: params.albumId);
    else return null;
  }

}

class GetFirstPhotoUseCaseParams extends UseCaseParams {
  final int albumId;
  GetFirstPhotoUseCaseParams({required this.albumId});
}