import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/photo.dart';

class AlbumDetailsState {
  static final albumIdProvider = ScopedProvider<int>((ref) => throw UnimplementedError());
  static final currentPhotosListProvider = ScopedProvider<List<Photo>>((ref) => throw UnimplementedError());
  static final currentPhotoProvider = ScopedProvider<Photo>((ref) => throw UnimplementedError());

  static final photosListProvider = StateProvider<List<Photo>?>((ref) 
      => []);
}