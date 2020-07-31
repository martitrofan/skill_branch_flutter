import 'package:FlutterGalleryApp/res/colors.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() => runApp(MyApp(Connectivity().onConnectivityChanged));

class ConnectivityOverlay {
  static final ConnectivityOverlay _singleton = ConnectivityOverlay._internal();

  factory ConnectivityOverlay() {
    return _singleton;
  }

  ConnectivityOverlay._internal();

  static OverlayEntry overlayEntry;

  void showOverlay(BuildContext context, Widget child) {
    overlayEntry = _overlayWidget(child);
    final overlayContext = Overlay.of(context);
    overlayContext?.insert(overlayEntry);
  }

  void removeOverlay() {
    overlayEntry?.remove();
  }

  OverlayEntry _overlayWidget(Widget child) {
    return OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: 100,
          child: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.mercury,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}