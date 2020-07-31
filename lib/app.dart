import 'dart:io';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/home.dart';
import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:connectivity_platform_interface/src/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  PageRoute pageRoute;
  final Stream<ConnectivityResult> onConnectivityChanged;

  MyApp(this.onConnectivityChanged);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(onConnectivityChanged),
      theme: ThemeData(textTheme: buildAppTextTheme()),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) => SafeArea(
              child: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Text('404'), Text('Page not found')],
                  ),
                ),
              ),
            ));
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args = (settings.arguments as FullScreenImageArguments);
          final route = FullScreenImage(
            photo: args.photo,
            altDescription: args.altDescription,
            userName: args.userName,
            name: args.name,
            userPhoto: args.userPhoto,
            heroTag: args.heroTag,
          );

          if (Platform.isIOS) {
            pageRoute = CupertinoPageRoute(
              builder: (context) => route,
              settings: args.settings,
            );
          } else if (Platform.isAndroid) {
            pageRoute = MaterialPageRoute(
              builder: (context) => route,
              settings: args.settings,
            );
          }
        }
        return pageRoute;
      },
    );
  }
}