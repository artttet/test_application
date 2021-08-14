import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/screens/user_details/screen.dart';
import 'package:test_application/src/presentation/screens/user_details/state.dart';

class UserDetailsPage extends Page {
  final int userId;
  UserDetailsPage({required this.userId}) : super(key: ValueKey('User Details Page - id:$userId'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (conext) => ProviderScope(
        overrides: [
          UserDetailsState.userIdProvider.overrideWithValue(userId)
        ],
        child: const UserDetailsScreen()
      )
    );
  }
}