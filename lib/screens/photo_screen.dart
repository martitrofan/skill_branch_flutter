import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';

class FullScreenImageArguments {
  FullScreenImageArguments({
    this.key,
    this.photo,
    this.altDescription,
    this.userName,
    this.name,
    this.userPhoto,
    this.heroTag,
    this.settings,
  });

  final Key key;
  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String userPhoto;
  final String heroTag;
  final RouteSettings settings;
}

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    this.photo = '',
    this.altDescription = '',
    this.userName = '',
    this.name = '',
    this.userPhoto = '',
    this.heroTag,
    Key key,
  }) : super(key: key);

  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String userPhoto;
  final String heroTag;

  @override
  State<StatefulWidget> createState() {
    return FullScreenImageState();
  }
}

class FullScreenImageState extends State<FullScreenImage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> opacityDescription;
  Animation<double> opacityAvatar;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);

    opacityDescription = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.5,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    opacityAvatar = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.5,
          curve: Curves.ease,
        ),
      ),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(ModalRoute.of(context).settings.arguments);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.heroTag,
              child: Photo(photoLink: widget.photo),
            ),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h3,
              ),
            ),
            const SizedBox(height: 9),
            _buildPhotoMeta(),
            const SizedBox(height: 17),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.more_vert,
              color: AppColors.grayChateau,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.mercury,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(10, (index) => FlutterLogo()),
                    ),
                  );
                },
              );
            })
      ],
      leading: IconButton(
        icon: Icon(
          CupertinoIcons.back,
          color: AppColors.grayChateau,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: AppColors.white,
      centerTitle: true,
      title: Text(
        'Photo',
        style: AppStyles.h2Black,
      ),
    );
  }

  Widget _buildPhotoMeta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          AnimatedBuilder(
            animation: controller,
            child: UserAvatar(widget.userPhoto),
            builder: (context, Widget child) {
              return Opacity(opacity: opacityAvatar.value, child: child);
            },
          ),
          SizedBox(width: 10),
          AnimatedBuilder(
            animation: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
              Text(
              widget.name,
              style: AppStyles.h1Black,
            ),
            Text("@${widget.userName}", style: AppStyles.h5Black.copyWith(color: AppColors.manatee)),
            ],
            ),
            builder: (context, Widget child) {
              return Opacity(opacity: opacityDescription.value, child: child);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          LikeButton(),
          SizedBox(
            width: 14,
          ),
          Expanded(
            child: _buildButton('Save', () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Alert Dialog title"),
                    content: Text("Alert Dialog body"),
                    actions: <Widget>[
                    FlatButton(
                    child: Text("Ok"),
                    onPressed: () {
                  Navigator.of(context).pop();
                  },
                  ),
                  FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                  Navigator.of(context).pop();
                  },
                  ),
                  ],
                  );
                },
              );
            }),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildButton('Visit', () async {
              OverlayState overlayState = Overlay.of(context);

              OverlayEntry overlayEntry = OverlayEntry(
                  builder: (BuildContext context) => Positioned(
                      top: MediaQuery.of(context).viewInsets.top + 50,
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.mercury,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                              child: Text(
                                'SkillBranch',
                              ),
                            ),
                          ),
                        ),
                      )));
              overlayState.insert(overlayEntry);
              await new Future.delayed(Duration(seconds: 1));
              overlayEntry?.remove();
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback callback) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        alignment: Alignment.center,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          text,
          style: AppStyles.h4.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
