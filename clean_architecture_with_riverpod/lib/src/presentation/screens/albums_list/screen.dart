import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/albums_list/controller.dart';
import 'package:test_application/src/presentation/screens/albums_list/state.dart';

class AlbumsListScreen extends StatelessWidget {
  const AlbumsListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.albums),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final controller = watch(albumsListControllerProvider);
          final userId = watch(AlbumsListState.userIdProvider);

          return FutureBuilder(
            future: controller.getAlbumsList(userId: userId, isPreview: false),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const _Content();
              } else {
                return const _Loading();
              }
            }
          );
        },
      ),
    );
  }
}

class _Content extends ConsumerWidget {
  const _Content();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final albumsList = watch(AlbumsListState.albumsListProvider).state;

    if (albumsList != null) {
      if (albumsList.isNotEmpty) {
        return ProviderScope(
          overrides: [
            AlbumsListState.currentAlbumsListProvider.overrideWithValue(albumsList)
          ],
          child: const Center(
            child: const _AlbumsList()
          ),
        );
      } else {
        return const _Loading();
      }   
    } else {
      return const _AlbumsNotFound();
    } 
  }
}

class _Loading extends StatelessWidget {
  const _Loading();
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: const CircularProgressIndicator(
        color: Colors.purple,
      ),
    );
  }
}

class _AlbumsNotFound extends StatelessWidget {
  const _AlbumsNotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.albumsNotFound,
            style: theme.textTheme.headline5?.copyWith(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0,),
          Consumer(
            builder: (context, watch, _) {
              final controller = watch(albumsListControllerProvider);
              final userId = watch(AlbumsListState.userIdProvider);

              return MaterialButton(
                height: 38.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                colorBrightness: Brightness.dark,
                child: Text(AppStrings.update),
                onPressed: () => controller.updateAlbumsList(userId: userId, isPreview: false)
              );
            }
          )
        ],
      ),
    );
  }
}

class _AlbumsList extends ConsumerWidget {
  const _AlbumsList();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final albumsList = watch(AlbumsListState.currentAlbumsListProvider);

    return ListView.separated(
      itemCount: albumsList.length,
      separatorBuilder: (context, index) => const Divider(height: 0.0,),
      itemBuilder: (context, index) {
        final album = albumsList[index];

        return ProviderScope(
          overrides: [
            AlbumsListState.currentAlbum.overrideWithValue(album)
          ],
          child: const _AlbumsListTile()
        );
      }
    );
  }
}

class _AlbumsListTile extends ConsumerWidget {
  const _AlbumsListTile();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(albumsListControllerProvider);
    final album = watch(AlbumsListState.currentAlbum);

    return ListTile(
      title: Text(album.title),
      onTap: () => controller.onAlbumListTilePressed(id: album.id),
    );
  }
}