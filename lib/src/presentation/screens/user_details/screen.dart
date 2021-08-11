import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/domain/entities/user.dart';
import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/user_details/controller.dart';
import 'package:test_application/src/presentation/screens/user_details/state.dart';
import 'package:test_application/src/presentation/screens/user_details/utils.dart';
import 'package:test_application/src/presentation/screens/user_details/widgets/album_previews_list.dart';
import 'package:test_application/src/presentation/screens/user_details/widgets/loading.dart';
import 'package:test_application/src/presentation/screens/user_details/widgets/post_previews_list.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const _Title()
      ),
      body: Consumer(
        builder: (context, watch, _) {
          final userId = watch(UserDetailsState.userIdProvider);
          final controller = watch(userDetailsControllerProvider);

          return FutureBuilder(
            future: controller.getUser(id: userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Consumer(
                  builder: (context, watch, _) {
                    final user = watch(UserDetailsState.userProvider).state;
      
                    if (user is UserEmpty) {
                      return const Loading();
                    }
      
                    if (user == null) {
                      return const _UserNotFound();
                    } else {
                      return ProviderScope(
                        overrides: [
                          UserDetailsState.currentUserProvider.overrideWithValue(user)
                        ],
                        child: const _Content()
                      );
                    }
                  },
                );
              } else {
                return const Loading();
              }
            }
          );
        }
      ),
    );
  }
}

class _Title extends ConsumerWidget {
  const _Title();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(UserDetailsState.userProvider).state;

    if (user == null || user is UserEmpty) {
      return const SizedBox.shrink();
    } else {
      return Text(user.username);
    }
  }
}

class _UserNotFound extends StatelessWidget {
  const _UserNotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.userNotFound,
            style: theme.textTheme.headline5?.copyWith(
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
                onPressed: () => controller.updateUser(id: userId)
              );
            }
          )
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: const _NameAndEmail(),
          ),
          const SizedBox(height: 48.0,),
          const _Phone(),
          const SizedBox(height: 24.0,),
          const _Website(),
          const SizedBox(height: 24.0,),
          const _Working(),
          const SizedBox(height: 24.0,),
          const _Address(),
          const SizedBox(height: 32.0,),
          const PostPreviewsList(),
          const SizedBox(height: 8.0,),
          const AlbumPreviewsList()
        ],
      ),
    );
  }
}

class _NameAndEmail extends ConsumerWidget {
  const _NameAndEmail();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(UserDetailsState.currentUserProvider);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(currentUser.name, style: textTheme.headline5,),
        const SizedBox(height: 2.0,),
        Text(currentUser.email, style: textTheme.bodyText2!.copyWith(color: Colors.grey),)
      ],
    );
  }
}

class _Phone extends ConsumerWidget {
  const _Phone();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(UserDetailsState.currentUserProvider);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.phone.toUpperCase(), style: textTheme.subtitle2?.copyWith(color: Colors.grey),),
        const SizedBox(height: 4.0,),
        Text(currentUser.phone, style: textTheme.bodyText1,)
      ],
    );
  }
}

class _Website extends ConsumerWidget {
  const _Website();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(UserDetailsState.currentUserProvider);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.website.toUpperCase(), style: textTheme.subtitle2?.copyWith(color: Colors.grey),),
        const SizedBox(height: 4.0,),
        Text(currentUser.website, style: textTheme.bodyText1,)
      ],
    );
  }
}

class _Working extends ConsumerWidget {
  const _Working();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(UserDetailsState.currentUserProvider);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.company.toUpperCase(), style: textTheme.subtitle2?.copyWith(color: Colors.grey),),
        const SizedBox(height: 4.0,),
        Text(currentUser.company.name, style: textTheme.bodyText1,),
        const SizedBox(height: 2.0,),
        Text(currentUser.company.bs, style: textTheme.bodyText2?.copyWith(color: Colors.grey),),
        const SizedBox(height: 2.0,),
        Text('"${currentUser.company.catchPhrase}"', style: textTheme.bodyText2?.copyWith(color: Colors.grey, fontStyle: FontStyle.italic),)
      ],
    );
  }
}

class _Address extends ConsumerWidget {
  const _Address();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final currentUser = watch(UserDetailsState.currentUserProvider);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.address.toUpperCase(), style: textTheme.subtitle2?.copyWith(color: Colors.grey),),
        const SizedBox(height: 4.0,),
        Text(UserDetailsUtils.getFullAddress(currentUser.address), style: textTheme.bodyText1,)
      ],
    );
  }
}