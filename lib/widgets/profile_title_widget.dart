import 'package:flutter/material.dart';
import 'package:sociallite/constants/Constantcolors.dart';

class ProfileTitleWidget extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60);

  const ProfileTitleWidget({
    Key? key,
    required this.constantColors,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  final ConstantColors constantColors;
  final String title1;
  final String title2;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title1,
        style: TextStyle(
          color: constantColors.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        children: <TextSpan>[
          TextSpan(
            text: title2,
            style: TextStyle(
              color: constantColors.blueColor,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
