import 'package:flutter/material.dart';

import 'package:test_application/src/presentation/screens/not_found/screen.dart';

class NotFoundPage extends Page {
  const NotFoundPage() : super(key: const ValueKey('Not Found Page'));

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => NotFoundScreen()
    );
  }
}