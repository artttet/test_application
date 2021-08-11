import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/screens/album_details/screen.dart';
import 'package:test_application/src/presentation/screens/album_details/state.dart';

class AlbumDetailsPage extends Page {
  final int albumId;
  AlbumDetailsPage({required this.albumId}) : super(key: ValueKey('Album Details Page - id:$albumId'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (conext) => ProviderScope(
        overrides: [
          AlbumDetailsState.albumIdProvider.overrideWithValue(albumId)
        ],
        child: const AlbumDetailsScreen()
      )
    );
  }
}