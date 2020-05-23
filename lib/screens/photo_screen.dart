import 'package:FlutterGalleryApp/res/res.dart';
import 'package:FlutterGalleryApp/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    this.photo =
        'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png',
    this.altDescription = '',
    this.userName = '',
    this.name = '',
    this.userPhoto =
        'https://i.pinimg.com/236x/d4/ac/87/d4ac8776f114aa0845adf4a1ebb02b44.jpg',
    this.countLike = 0,
    this.isLike = false,
    this.heroTag = '',
    Key key,
  }) : super(key: key);

  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String userPhoto;
  final int countLike;
  final bool isLike;
  final String heroTag;

  @override
  State<StatefulWidget> createState() => FullScreenImageState();
}

class FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _playAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _animationController.forward().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: widget.heroTag,
              child: Photo(
                photoLink: widget.photo,
              ),
            ),
            const SizedBox(
              height: 11,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.altDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.h3,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            _buildPhotoMeta(),
            const SizedBox(
              height: 17,
            ),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
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
    return PhotoMetaUser(
      controller: _animationController,
      name: widget.name,
      nikName: widget.userName,
      userPhoto: widget.userPhoto,
    );
    /*return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: <Widget>[
          UserAvatar(widget.userPhoto),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.name,
                style: AppStyles.h1Black,
              ),
              Text(
                "@${widget.userName}",
                style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
              ),
            ],
          )
        ],
      ),
    );*/
  }

  Widget _buildActionButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: LikeButton(
              likeCount: widget.countLike,
            ),
          ),
          Expanded(
            child: _buildButton('Save'),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: _buildButton('Visit'),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Container(
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
    );
  }
}

class PhotoMetaUser extends StatelessWidget {
  PhotoMetaUser(
      {this.controller, this.name, this.nikName, this.userPhoto, Key key})
      : opacityUserAvatar = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.ease,
            ),
          ),
        ),
        opacityUserName = Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController controller;
  final Animation<double> opacityUserAvatar;
  final Animation<double> opacityUserName;
  final String name;
  final String nikName;
  final String userPhoto;

  Widget _buildPhotoMeta(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: <Widget>[
              Opacity(
                opacity: opacityUserAvatar.value,
                child: UserAvatar(userPhoto),
              ),
              SizedBox(width: 6),
              Opacity(
                opacity: opacityUserName.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      (name != null) ? name : '',
                      style: AppStyles.h1Black,
                    ),
                    Text(
                      (nikName != null) ? '@${nikName}' : '',
                      style: AppStyles.h5Black.copyWith(
                        color: AppColors.manatee,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildPhotoMeta,
      animation: controller,
    );
  }
}
