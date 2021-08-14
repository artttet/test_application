import 'package:test_application/src/domain/entities/album.dart';
import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/entities/post.dart';
import 'package:test_application/src/domain/entities/user.dart';
import 'package:test_application/src/domain/repositories/album_repository.dart';
import 'package:test_application/src/domain/repositories/photo_repository.dart';
import 'package:test_application/src/domain/repositories/post_repository.dart';
import 'package:test_application/src/domain/repositories/user_repository.dart';
import 'package:test_application/src/domain/usecases/album/get_list_usecase.dart';
import 'package:test_application/src/domain/usecases/photo/get_usecase.dart';
import 'package:test_application/src/domain/usecases/post/get_list_usecase.dart';
import 'package:test_application/src/domain/usecases/user/get_usecase.dart';

class UserDetailsPresenter {
  final UserRepository _userRepository; // ignore: unused_field
  final PostRepository _postRepository; // ignore: unused_field
  final AlbumRepository _albumRepository; // ignore: unused_field
  final PhotoRepository _photoRepository; // ignore: unused_field
  final GetUserUseCase _getUserUseCase;
  final GetPostsListUseCase _getPostsListUseCase;
  final GetAlbumsListUseCase _getAlbumsListUseCase;
  final GetFirstPhotoUseCase _getFirstPhotoUseCase;

  UserDetailsPresenter(this._userRepository, this._postRepository, this._albumRepository, this._photoRepository)
      : _getUserUseCase = GetUserUseCase(_userRepository),
        _getPostsListUseCase = GetPostsListUseCase(_postRepository),
        _getAlbumsListUseCase = GetAlbumsListUseCase(_albumRepository),
        _getFirstPhotoUseCase = GetFirstPhotoUseCase(_photoRepository);


  Future<User?> getUser({required int id}) async {
    final params = GetUserUseCaseParams(id: id);
    return await _getUserUseCase.execute(params: params);
  }

  Future<List<Post>?> getPostsList({required int userId, required bool isPreview}) async {
    final params = GetPostsListUseCaseParams(userId: userId, isPreview: isPreview);
    return await _getPostsListUseCase.execute(params: params);
  }

  Future<List<Album>?> getAlbumsList({required int userId, required bool isPreview}) async {
    final params = GetAlbumsListUseCaseParams(userId: userId, isPreview: isPreview);
    return await _getAlbumsListUseCase.execute(params: params);
  }

  Future<Photo?> getFirstPhoto({required int albumId}) async {
    final params = GetFirstPhotoUseCaseParams(albumId: albumId);
    return await _getFirstPhotoUseCase.execute(params: params);
  }
}