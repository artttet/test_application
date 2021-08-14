import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/dependecies/repository_module.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack_item.dart';
import 'package:test_application/src/presentation/screens/users_list/presenter.dart';
import 'package:test_application/src/presentation/screens/users_list/state.dart';

final usersListControllerProvider = Provider((ref)
    => UsersListController(read: ref.read));

class UsersListController {
  final Reader read;
  final UsersListPresenter usersListPresenter;
  UsersListController({required this.read})
      : usersListPresenter = UsersListPresenter(RepositoryModule.userShortRepository()!);

  void onUserListTilePressed({required int userId}) {
    read(mainNavigationStackProvider).push(
      MainNavigationStackItem.userDetails(userId: userId)
    );
  }

  Future getUserShortList() async {
    final userShortList = read(UsersListState.userShortListProvider);
    final receivedUserShortList = await usersListPresenter.getUserShortList();
    receivedUserShortList?.sort((a, b) => a.id.compareTo(b.id));
    userShortList.state = receivedUserShortList;
  }

  void updateUserShortList() async {
    final userShortList = read(UsersListState.userShortListProvider);
    userShortList.state = [];
    await getUserShortList();
  }    
}