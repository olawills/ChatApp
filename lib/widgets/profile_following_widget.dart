import 'package:flutter/material.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:sociallite/widgets/container_followers_widget.dart';

class FollowingWidget extends StatelessWidget {
  const FollowingWidget({
    Key? key,
    required this.constantColors,
  }) : super(key: key);

  final ConstantColors constantColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: ContainerFollowersWidget(
                      constantColors: constantColors,
                      text1: '0',
                      text2: 'Followers'),
                ),
                ContainerFollowersWidget(
                    constantColors: constantColors,
                    text1: '0',
                    text2: 'Following'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: constantColors.darkColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: 70.0,
              width: 80.0,
              child: Column(
                children: [
                  Text(
                    '0',
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0,
                    ),
                  ),
                  Text(
                    'Posts',
                    style: TextStyle(
                      color: constantColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
