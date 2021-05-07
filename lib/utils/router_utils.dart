import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinder_task_2/screens/swipe/page/swipe_page.dart';

import '../constants/routing_constants.dart';
import '../screens/error_page.dart';
import '../screens/login_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    // Fop POP up from Bottom Use Material Page Route

    /* **************
    * Login Screen *
    *****************/
    case RouteConst.loginPageRoute:
      return CupertinoPageRoute(
          builder: (context) => LoginPage(), settings: settings);

    /* **************
    * Card Swipe Screen *
    *****************/
    case RouteConst.cardSwipePageRoute:
      return CupertinoPageRoute(
          // builder: (context) => BlocProvider(
          //     create: (context) => TinderBloc(
          //         getLocalData: TinderLocalData(),
          //         getNetwork: NetworkData(),
          //         getNetworkData: TinderNetworkData()),
          //     child: TinderPage()),
          // settings: settings);
          builder: (context) => SwipePage(),
          settings: settings);

    /* **************
    * Unfinished Screen *
    *****************/
    default:
      return CupertinoPageRoute(
          builder: (context) => ErrorPage(), settings: settings);
  }
}
