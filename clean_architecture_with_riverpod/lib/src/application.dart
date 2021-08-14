import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:test_application/src/presentation/core/navigators/main_navigator/main_navigation_stack.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_route_information_parser.dart';
import 'package:test_application/src/presentation/core/navigators/main_navigator/main_router_delegate.dart';

class Application extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routeInformationParser: MainRouteInformationParser(),
      routerDelegate: MainRouterDelegate(
        stack: context.read(mainNavigationStackProvider)
      )
    );
  }
}