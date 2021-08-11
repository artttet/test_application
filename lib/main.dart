import 'package:flutter/widgets.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/application.dart';

void main() {
  runApp(
    ProviderScope(child: Application())
  );
}

