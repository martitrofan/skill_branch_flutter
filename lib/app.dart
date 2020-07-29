import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';
import 'screens/photo_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData(
        textTheme: TextTheme(headline1: TextStyle(color: Colors.black26)),
      ),
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  Text('404'),
                  Text('Page not found'),
                ],
              ),
            ),
          );
        });
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == '/fullScreenImage') {
          FullScreenImageArguments args =
              (settings.arguments as FullScreenImageArguments);
          final route = FullScreenImage(
            photo: args.photo,
            altDescription: args.altDescription,
            userName: args.userName,
            name: args.name,
            userPhoto: args.userPhoto,
            heroTag: args.heroTag,
          );

          if (Platform.isAndroid) {
            return CupertinoPageRoute(
                builder: (context) => route, settings: args.settings);
          } else if (Platform.isIOS) {
            return MaterialPageRoute(
                builder: (context) => route, settings: args.settings);
          }
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
