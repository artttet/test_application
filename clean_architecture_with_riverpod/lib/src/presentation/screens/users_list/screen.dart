import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/strings.dart';
import 'package:test_application/src/presentation/screens/users_list/controller.dart';
import 'package:test_application/src/presentation/screens/users_list/state.dart';

class UsersListScreen extends StatelessWidget {
  const UsersListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppStrings.users),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final controller = watch(usersListControllerProvider);

          return FutureBuilder(
            future: controller.getUserShortList(),
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
    final userShortList = watch(UsersListState.userShortListProvider).state;

    if (userShortList != null) {
      if (userShortList.isNotEmpty) {
        return ProviderScope(
          overrides: [
            UsersListState.currentUserShortListProvider.overrideWithValue(userShortList)
          ],
          child: const Center(
            child: const _UsersList()
          ),
        );
      } else {
        return const _Loading();
      }   
    } else {
      return const _UsersNotFound();
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

class _UsersNotFound extends StatelessWidget {
  const _UsersNotFound();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppStrings.usersNotFound,
            style: theme.textTheme.headline5?.copyWith(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8.0,),
          Consumer(
            builder: (context, watch, _) {
              final controller = watch(usersListControllerProvider);

              return MaterialButton(
                height: 38.0,
                color: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                colorBrightness: Brightness.dark,
                child: Text(AppStrings.update),
                onPressed: () => controller.updateUserShortList()
              );
            }
          )
        ],
      ),
    );
  }
}

class _UsersList extends ConsumerWidget {
  const _UsersList();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final userShortList = watch(UsersListState.currentUserShortListProvider);

    return ListView.separated(
      itemCount: userShortList.length,
      separatorBuilder: (context, index) => const Divider(height: 0.0,),
      itemBuilder: (context, index) {
        final userShort = userShortList[index];

        return ProviderScope(
          overrides: [
            UsersListState.currentUserShortProvider.overrideWithValue(userShort)
          ],
          child: const _UsersListTile()
        );
      }
    );
  }
}

class _UsersListTile extends ConsumerWidget {
  const _UsersListTile();
  
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(usersListControllerProvider);
    final userShort = watch(UsersListState.currentUserShortProvider);

    return ListTile(
      title: Text(userShort.username),
      subtitle: Text(userShort.name),
      onTap: () => controller.onUserListTilePressed(userId: userShort.id),
    );
  }
}