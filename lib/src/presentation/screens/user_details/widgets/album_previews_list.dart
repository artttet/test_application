import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/photo.dart';
import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/user_details/controller.dart';
import 'package:test_application/src/presentation/screens/user_details/state.dart';
import 'package:test_application/src/presentation/screens/user_details/widgets/loading.dart';

class AlbumPreviewsList extends StatelessWidget {
  const AlbumPreviewsList();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.albums.toUpperCase(), style: textTheme.subtitle2?.copyWith(color: Colors.grey),),
        const SizedBox(height: 8.0,),
        const _AlbumsCard(),
      ],
    );
  }
}

class _AlbumsCard extends ConsumerWidget {
  const _AlbumsCard();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(userDetailsControllerProvider);
    final userId = watch(UserDetailsState.userIdProvider);

    return FutureBuilder(
      future: controller.getAlbumsList(userId: userId, isPreview: true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer(
            builder: (context, watch, _) {
              final albumsList = watch(UserDetailsState.albumsListProvider).state;

              if (albumsList == null) return const _AlbumsNotFound();

              if (albumsList.isEmpty) {
                return const Loading();
              } else {
                return ProviderScope(
                  overrides: [
                    UserDetailsState.currentAlbumsList.overrideWithValue(albumsList)
                  ],
                  child: const _AlbumsCardContent()
                );
              }
            }
          );
        }

        return const Loading();
      }
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
            style: theme.textTheme.headline6?.copyWith(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0,),
          Consumer(
            builder: (context, watch, _) {
              final controller = watch(userDetailsControllerProvider);
              final userId = watch(UserDetailsState.userIdProvider);

              return MaterialButton(
                height: 38.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                colorBrightness: Brightness.dark,
                child: Text(AppStrings.update),
                onPressed: () => controller.updateAlbumsList(userId: userId, isPreview: true)
              );
            }
          )
        ],
      ),
    );
  }
}

class _AlbumsCardContent extends ConsumerWidget {
  const _AlbumsCardContent();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(userDetailsControllerProvider);
    final userId = watch(UserDetailsState.userIdProvider);

    final currentAlbumsList = watch(UserDetailsState.currentAlbumsList);

    return Column(
      children: [
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            children: currentAlbumsList.map((album) => Column(
              children: [
                ProviderScope(
                  overrides: [
                    UserDetailsState.currentAlbum.overrideWithValue(album)
                  ],
                  child: const _AlbumPreviewTile()
                ),
                if (currentAlbumsList.indexOf(album) != currentAlbumsList.length-1) Divider(height: 0.0,)
              ],
            )).toList(),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: MaterialButton(
            child: const Text(AppStrings.more),
            onPressed: () => controller.goToAlbumsListScreen(userId: userId),
          ),
        )
      ],
    );
  }
}

class _AlbumPreviewTile extends ConsumerWidget {
  const _AlbumPreviewTile();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentAlbum = watch(UserDetailsState.currentAlbum);
    final controller = watch(userDetailsControllerProvider);

    return  ListTile(
      leading: FutureBuilder<Photo?>(
        future: controller.getFirstPhoto(albumId: currentAlbum.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final data = snapshot.data;

            if (data == null) {
                return const _AlbumPhotoEmpty();
              } else {
                return ProviderScope(
                  overrides: [
                    UserDetailsState.currentFirstPhoto.overrideWithValue(data)
                  ],
                  child: const _AlbumPhoto()
                );
              }
          }

          return const _AlbumPhotoEmpty();
        },
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(currentAlbum.title),
    );
  }
}

class _AlbumPhoto extends ConsumerWidget {
  const _AlbumPhoto();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentFirstPhoto = watch(UserDetailsState.currentFirstPhoto);

    return CircleAvatar(
      radius: 15.0,
      backgroundColor: Colors.grey.shade300,
      backgroundImage: NetworkImage(currentFirstPhoto.thumbnailUrl),
    );
  }
}

class _AlbumPhotoEmpty extends StatelessWidget {
  const _AlbumPhotoEmpty();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15.0,
      backgroundColor: Colors.grey.shade300,
    );
  }
  
}