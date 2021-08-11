import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/album_details/controller.dart';
import 'package:test_application/src/presentation/screens/album_details/state.dart';

class AlbumDetailsScreen extends StatelessWidget {
  const AlbumDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.album),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final controller = watch(albumDetailsControllerProvider);
          final albumId = watch(AlbumDetailsState.albumIdProvider);

          return FutureBuilder(
            future: controller.getPhotosList(albumId: albumId),
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
    final photosList = watch(AlbumDetailsState.photosListProvider).state;

    if (photosList != null) {
      if (photosList.isNotEmpty) {
        return ProviderScope(
          overrides: [
            AlbumDetailsState.currentPhotosListProvider.overrideWithValue(photosList)
          ],
          child: const Center(
            child: const _PhotosSlider()
          ),
        );
      } else {
        return const _Loading();
      }   
    } else {
      return const _PhotosNotFound();
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

class _PhotosNotFound extends StatelessWidget {
  const _PhotosNotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.photosNotFound,
            style: theme.textTheme.headline5?.copyWith(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0,),
          Consumer(
            builder: (context, watch, _) {
              final controller = watch(albumDetailsControllerProvider);
              final albumId = watch(AlbumDetailsState.albumIdProvider);

              return MaterialButton(
                height: 38.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                colorBrightness: Brightness.dark,
                child: Text(AppStrings.update),
                onPressed: () => controller.updatePhotosList(albumId: albumId)
              );
            }
          )
        ],
      ),
    );
  }
}

class _PhotosSlider extends ConsumerWidget {
  const _PhotosSlider();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentPhotosList = watch(AlbumDetailsState.currentPhotosListProvider);

    return PageView.builder(
      itemCount: currentPhotosList.length,
      itemBuilder: (context, index) => ProviderScope(
        overrides: [
          AlbumDetailsState.currentPhotoProvider.overrideWithValue(currentPhotosList[index])
        ],
        child: const _PhotosSliderItem()
      )
    );
  }
}

class _PhotosSliderItem extends StatelessWidget {
  const _PhotosSliderItem();
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: const _Photo()
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: const _PhotoTitle()
        )
      ]
    );
  }
}

class _Photo extends ConsumerWidget {
  const _Photo();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final photo = watch(AlbumDetailsState.currentPhotoProvider);

    return Image.network(photo.url,
        fit: BoxFit.fill,
    );
  }
}

class _PhotoTitle extends StatelessWidget {
  const _PhotoTitle();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black54],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 1.0],
        )
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer(
          builder: (context, watch, child) {
            final photo = watch(AlbumDetailsState.currentPhotoProvider);

            return Text(photo.title, style: textTheme.bodyText1?.copyWith(color: Colors.white),);
          }
        ),
      ),
    );
  }
}