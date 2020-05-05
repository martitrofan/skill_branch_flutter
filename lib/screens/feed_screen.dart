import 'package:FlutterGalleryApp/screens/photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../res/res.dart';
import '../widgets/widgets.dart';

const String kFlutterDash =
    'https://flutter.dev/assets/404/dash_nest-c64796b59b65042a2b40fae5764c13b7477a592db79eaf04c86298dcb75b78ea.png';
//const String kAvatar = 'https://skill-branch.ru/img/speakers/Adechenko.jpg';
const String kAvatar =
    'https://i.pinimg.com/236x/d4/ac/87/d4ac8776f114aa0845adf4a1ebb02b44.jpg';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                _buildItem(),
                Divider(
                  thickness: 2,
                  color: AppColors.mercury,
                ),
              ],
            );
          }),
    );
  }

  Widget _buildItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          child: Photo(
            photoLink: kFlutterDash,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    FullScreenImage(
                      photo: kFlutterDash,
                      userPhoto: kAvatar,
                      name: 'Kirill Adeschenko',
                      userName: '@kaparray',
                      altDescription: 'This is a Flutter dash :D',
                      countLike: 15,
                    ),
              ),
            );
          },
        ),
        _buildPhotoMeta(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            'This is a Flutter dash :D',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}

Widget _buildPhotoMeta() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            //UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
            UserAvatar(kAvatar),
            SizedBox(
              width: 6,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Kirill Adeschenko',
                  style: AppStyles.h2Black,
                ),
                Text(
                  '@kaparray',
                  style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                ),
              ],
            )
          ],
        ),
        LikeButton(
          likeCount: 15,
        ),
      ],
    ),
  );
}



