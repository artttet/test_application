import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/album.dart';
import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/domain/entities/post.dart';

import 'package:test_application/src/domain/entities/user.dart';

class UserDetailsState {
  static final userIdProvider = ScopedProvider<int>((ref) => throw UnimplementedError());
  static final currentUserProvider = ScopedProvider<User>((ref) => throw UnimplementedError());
  static final userProvider = StateProvider<User?>((ref) => UserEmpty());

  static final currentPost = ScopedProvider<Post>((ref) => throw UnimplementedError());
  static final currentPostsList = ScopedProvider<List<Post>>((ref) => throw UnimplementedError());
  static final postsListProvider = StateProvider<List<Post>?>((ref) => []);

  static final currentAlbum = ScopedProvider<Album>((ref) => throw UnimplementedError());
  static final currentAlbumsList = ScopedProvider<List<Album>>((ref) => throw UnimplementedError());
  static final albumsListProvider = StateProvider<List<Album>?>((ref) => []);

  static final currentFirstPhoto = ScopedProvider<Photo>((ref) => throw UnimplementedError());
}