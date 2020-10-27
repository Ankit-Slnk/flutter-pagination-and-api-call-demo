/*

Code written by :
Ankit Solanki
Mobile Application Developer
Android • iOS • Flutter

*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterPaginationApi/screens/splash/splashScreen.dart';

import 'utility/appColors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [RouteObserver()],
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: AppColors.appColor,
      ),
    ),
  );
}
