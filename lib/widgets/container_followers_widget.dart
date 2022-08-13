import 'package:flutter/material.dart';
import 'package:sociallite/constants/Constantcolors.dart';

class ContainerFollowersWidget extends StatelessWidget {
  const ContainerFollowersWidget({
    Key? key,
    required this.constantColors,
    required this.text1,
    required this.text2,
  }) : super(key: key);

  final ConstantColors constantColors;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: constantColors.darkColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      height: 70.0,
      width: 80.0,
      child: Column(
        children: [
          Text(
            text1,
            style: TextStyle(
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              color: constantColors.whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
