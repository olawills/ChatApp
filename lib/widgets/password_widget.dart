import 'package:flutter/material.dart';
import 'package:sociallite/constants/Constantcolors.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    Key? key,
    required this.passwordController,
    required this.constantColors,
  }) : super(key: key);

  final TextEditingController passwordController;
  final ConstantColors constantColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextField(
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Enter Password...',
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
