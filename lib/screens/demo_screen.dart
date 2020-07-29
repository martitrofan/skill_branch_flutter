import 'package:flutter/material.dart';

class DemoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoScreenState();
  }
}

class DemoScreenState extends State<DemoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            FlatButton(
              child: Text('click me'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        ));
  }
}
