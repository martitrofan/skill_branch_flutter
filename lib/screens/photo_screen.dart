import 'package:FlutterGalleryApp/widgets/claim_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../widgets/widgets.dart';
import '../res/res.dart';

class FullScreenImageArguments {
  final Key key;
  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String userPhoto;
  final String heroTag;
  final RouteSettings settings;

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
}

class FullScreenImage extends StatefulWidget {
  String altDescription;
  String userName;
  String name;
  String userPhoto;
  String photo;
  String heroTag;

  FullScreenImage({photo, userPhoto, Key key, userName, name, altDescription, heroTag})
      : super(key: key) {
    this.heroTag = heroTag;
    this.userName = userName ?? 'guest';
    this.name = name ?? 'name';
    this.altDescription = altDescription ?? 'text...';
    this.photo = photo ??
        'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';
    this.userPhoto = userPhoto ??
        'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';
  }

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Photo'),
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.pop(context),
          ),
          actions: <Widget>[BottomSheetButton()],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.heroTag,
              child: Photo(photoLink: widget.userPhoto),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: <Widget>[
                      Opacity(
                        opacity: buildAnimationUserAvatar(),
                        child: UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
                      ),
                      SizedBox(width: 6.0),
                      Opacity(
                        opacity: buildAnimationUserMeta(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.name, style: Theme.of(context).textTheme.headline1),
                            Text(
                              '@' + widget.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: AppColors.manatee),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LikeButton(likeCount: 10, isLiked: true),
                  Row(
                    children: <Widget>[
                      _buildButton(txt: 'Save', needDialog: true),
                      SizedBox(width: 10),
                      _buildButton(txt: 'Visit'),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double buildAnimationUserMeta() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.ease),
      ),
    )
        .value;
  }

  double buildAnimationUserAvatar() {
    return Tween<double>(begin: 0.0, end: 1.0)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.ease),
      ),
    )
        .value;
  }

  Widget _buildButton({String txt = 'Button', bool needDialog = false}) {
    return GestureDetector(
      onTap: () {
        needDialog
            ? showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Downloading photos'),
              content: Text('Are you sure you want to upload a photo?'),
              elevation: 24,
              actions: <Widget>[
                FlatButton(
                  child: Text('Download'),
                  onPressed: () async {
                    await GallerySaver.saveImage(widget.photo);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Close'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          },
        )
            : '';
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          child: Text(txt, style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      ),
    );
  }
}

class BottomSheetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      color: AppColors.grayChateau,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => ClaimBottomSheet(),
        );
      },
    );
  }
}