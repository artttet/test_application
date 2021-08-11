import 'package:test_application/src/data/repositories/album_data_repository.dart';
import 'package:test_application/src/data/repositories/comment_data_repository.dart';
import 'package:test_application/src/data/repositories/photo_data_repository.dart';
import 'package:test_application/src/data/repositories/post_data_repository.dart';
import 'package:test_application/src/data/repositories/user_data_repository.dart';
import 'package:test_application/src/data/repositories/user_short_data_repository.dart';
import 'package:test_application/src/dependecies/api_module.dart';
import 'package:test_application/src/domain/repositories/album_repository.dart';
import 'package:test_application/src/domain/repositories/comment_repository.dart';
import 'package:test_application/src/domain/repositories/photo_repository.dart';
import 'package:test_application/src/domain/repositories/post_repository.dart';
import 'package:test_application/src/domain/repositories/user_repository.dart';
import 'package:test_application/src/domain/repositories/user_short_repository.dart';

class RepositoryModule {
  static UserShortRepository? _userShortRepository;
  static UserRepository? _userRepository;
  static PostRepository? _postRepository;
  static AlbumRepository? _albumRepository;
  static PhotoRepository? _photoRepository;
  static CommentRepository? _commentRepository;
  
  static UserShortRepository? userShortRepository() {
    if (_userShortRepository == null) {
      _userShortRepository = UserShortDataRepository(
        ApiModule.apiUtil()!
      );
    }
    return _userShortRepository;
  }

  static UserRepository? userRepository() {
    if (_userRepository == null) {
      _userRepository = UserDataRepository(
        ApiModule.apiUtil()!
      );
    }
    return _userRepository;
  }

  static PostRepository? postRepository() {
    if (_postRepository == null) {
      _postRepository = PostDataRepository(
        ApiModule.apiUtil()!
      );
    }
    return _postRepository;
  }

  static AlbumRepository? albumRepository() {
    if (_albumRepository == null) {
      _albumRepository = AlbumDataRepository(
        ApiModule.apiUtil()!
      );
    }
    return _albumRepository;
  }

  static PhotoRepository? photoRepository() {
    if (_photoRepository == null) {
      _photoRepository = PhotoDataRepository(
        ApiModule.apiUtil()!
      );
    }
    return _photoRepository;
  }

  static CommentRepository? commentRepository() {
    if (_commentRepository == null) {
      _commentRepository = CommentDataRepository(
        ApiModule.apiUtil()!
      );
    }
    return _commentRepository;
  }
}