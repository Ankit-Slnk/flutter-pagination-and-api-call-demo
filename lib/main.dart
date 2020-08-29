import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterPaginationApi/screens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorObservers: [RouteObserver()],
          home: SplashScreen(),
        ),
      );
    },
  );
}
