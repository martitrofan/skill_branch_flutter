import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClaimBottomSheet extends StatelessWidget {
  final List<String> complaint = ['adult', 'harm', 'bully', 'spam', 'copyright', 'hate'];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: complaint
          .map((item) => InkWell(
        child: Container(
          height: 50,
          child: Center(
            child: Text(
              item.toUpperCase(),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ),
        onTap: () => Navigator.pop(context),
      ))
          .toList(),
    );
  }
}