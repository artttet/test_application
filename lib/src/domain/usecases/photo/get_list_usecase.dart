import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/repositories/photo_repository.dart';
import 'package:test_application/src/domain/usecases/usecase.dart';

class GetPhotosListUseCase extends UseCase<Future<List<Photo>?>, GetPhotosListUseCaseParams> {
  final PhotoRepository _photoRepository;
  GetPhotosListUseCase(this._photoRepository);
  
  @override
  Future<List<Photo>?> execute({GetPhotosListUseCaseParams? params}) async {
    if (params != null) return await _photoRepository.getPhotosList(albumId: params.albumId);
    else return null;
  }
}

class GetPhotosListUseCaseParams extends UseCaseParams {
  final int albumId;
  GetPhotosListUseCaseParams({required this.albumId});
}