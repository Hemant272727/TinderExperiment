import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tinder_task_2/constants/routing_constants.dart';
import 'package:tinder_task_2/constants/string_constants.dart';
import 'package:tinder_task_2/utils/service_util.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isOnline = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      StringConst.googleRequest,
    ],
  );

  @override
  void initState() {
    super.initState();
    logout();
  }

  void logout() async {
    if (await ServiceUtil.checkInternetConnection()) {
      setState(() {
        isOnline = true;
      });
      try {
        _googleSignIn.signOut();
      } catch (e) {
        print('### Google Logout Error:  ${e.toString()}');
      }
    } else {
      setState(() {
        isOnline = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: isOnline
                  ? SignInButton(
                      Buttons.Google,
                      onPressed: () async {
                        try {
                          if (await ServiceUtil.checkInternetConnection()) {
                            _googleSignIn.signIn().then((value) async {
                              Navigator.pushNamed(
                                  context, RouteConst.cardSwipePageRoute);
                            });
                          }
                        } catch (e) {
                          print('### Google Login Error:  ${e.toString()}');
                        }
                      },
                    )
                  : TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteConst.cardSwipePageRoute);
                      },
                      child: Text('No Internet, Skip Login')),
            ),
          ],
        ),
      ),
    );
  }
}
