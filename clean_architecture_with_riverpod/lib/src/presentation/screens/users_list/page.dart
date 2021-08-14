import 'package:flutter/material.dart';

import 'package:test_application/src/presentation/screens/users_list/screen.dart';

class UsersListPage extends Page {
  const UsersListPage() : super(key: const ValueKey('Users List Page'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => const UsersListScreen()
    );
  }
}