import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/screens/feed_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currenTab = 0;
  List<Widget> pages = [
    Feed(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        borderRadius: 8,
        curve: Curves.ease,
        itemSelected: (int index) {
          setState(() {
            currenTab = index;
          });
        },
        currentTab: currenTab,
        items: [
          BottomNavyBarItem(
            asset: AppIcons.home,
            title: Text('Feed'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BottomNavyBarItem(
            asset: AppIcons.home,
            title: Text('Search'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
          BottomNavyBarItem(
            asset: AppIcons.home,
            title: Text('User'),
            activeColor: AppColors.dodgerBlue,
            inactiveColor: AppColors.manatee,
          ),
        ],
      ),
      body: pages[currenTab],
    );
  }
}

class BottomNavyBar extends StatelessWidget {
  BottomNavyBar({
    Key key,
    this.backgroundColor = Colors.white,
    this.showElevation = true,
    this.containerHeight = 56,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.items,
    this.itemSelected,
    this.currentTab,
    this.duration = const Duration(milliseconds: 270),
    this.borderRadius = 24,
    this.curve,
  }) : super(key: key);

  final Color backgroundColor;
  final bool showElevation;
  final double containerHeight;
  final MainAxisAlignment mainAxisAlignment;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> itemSelected;
  final int currentTab;
  final Duration duration;
  final double borderRadius;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: backgroundColor, boxShadow: [
        if (showElevation)
          const BoxShadow(color: Colors.black12, blurRadius: 2),
      ]),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: containerHeight,
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: items.map((item) {
              var index = items.indexOf(item);

              return GestureDetector(
                onTap: () => itemSelected(index),
                child: _ItemWidget(
                  item: item,
                  isSelected: currentTab == index,
                  backgroundColor: backgroundColor,
                  animationDuration: duration,
                  borderRadius: borderRadius,
                  curve: curve,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  _ItemWidget({
    @required this.isSelected,
    @required this.item,
    @required this.backgroundColor,
    @required this.animationDuration,
    this.curve = Curves.linear,
    @required this.borderRadius,
  })  : assert(animationDuration != null, 'animationDuration is null'),
        assert(curve != null, 'curve is null'),
        assert(isSelected != null, 'isSelected is null'),
        assert(item != null, 'item is null'),
        assert(backgroundColor != null, 'backgroundColor is null'),
        assert(borderRadius != null, 'borderRadius is null');

  final bool isSelected;
  final BottomNavyBarItem item;
  final Color backgroundColor;
  final Duration animationDuration;
  final Curve curve;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      duration: animationDuration,
      width: isSelected
          ? 150.0
          : (MediaQuery.of(context).size.width - 150 - 8 * 4 - 4 * 2) / 2,
      height: double.maxFinite,
      curve: curve,
      decoration: BoxDecoration(
        color: isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            item.asset,
            size: 20,
            color: isSelected ? item.activeColor : item.inactiveColor,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: DefaultTextStyle.merge(
                child: item.title,
                textAlign: item.textAlign,
                style: TextStyle(
                  color: isSelected ? item.activeColor : item.inactiveColor,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BottomNavyBarItem {
  BottomNavyBarItem({
    this.asset,
    this.title,
    this.activeColor,
    this.inactiveColor,
    this.textAlign,
  }) {
    assert(asset != null, 'Asset is null');
    assert(title != null, 'Asset is null');
  }

  final IconData asset;
  final Text title;
  final Color activeColor;
  final Color inactiveColor;
  final TextAlign textAlign;
}
