import 'package:flutter/material.dart';
import 'package:sociallite/constants/Constantcolors.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({
    Key? key,
    required this.emailController,
    required this.constantColors,
  }) : super(key: key);

  final TextEditingController emailController;
  final ConstantColors constantColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'Enter Email...',
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: constantColors.whiteColor,
            fontSize: 16.0,
          ),
        ),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: constantColors.whiteColor,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
