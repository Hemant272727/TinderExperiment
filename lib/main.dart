import 'package:flutter/material.dart';

import 'constants/routing_constants.dart';
import 'utils/router_utils.dart' as route;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteConst.loginPageRoute,
      onGenerateRoute: route.generateRoute,
    );
  }
}
