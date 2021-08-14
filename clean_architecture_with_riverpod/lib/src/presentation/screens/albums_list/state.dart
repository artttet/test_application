import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/album.dart';

class AlbumsListState {
  static final userIdProvider = ScopedProvider<int>((ref) => throw UnimplementedError());
  static final currentAlbumsListProvider = ScopedProvider<List<Album>>((ref) => throw UnimplementedError());
  static final currentAlbum = ScopedProvider<Album>((ref) => throw UnimplementedError());

  static final albumsListProvider = StateProvider<List<Album>?>((ref)
      => []);
}