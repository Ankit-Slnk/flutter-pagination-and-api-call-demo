import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterPaginationApi/screens/usersListScreen.dart';
import 'package:flutterPaginationApi/utility/appColors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // three second of delay for splash screen to display and the redirect to home
    Timer(Duration(seconds: 3), gotoHome);
  }

  gotoHome() {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(
          builder: (BuildContext context) => UsersListScreen(),
        ),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: FlutterLogo(),
    );
  }
}
