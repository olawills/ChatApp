import 'package:flutter/material.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:provider/provider.dart';
import 'package:sociallite/screens/landingPage/landingHelpers.dart';

class LandingPage extends StatelessWidget {
  //  LandingPage({Key? key}) : super(key: key);

  ConstantColors constantColors = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.whiteColor,
      body: Stack(
        children: [
          bodyColor(),
          Provider.of<Landinghelpers>(context, listen: false)
              .bodyImage(context),
          Provider.of<Landinghelpers>(context, listen: false)
              .taglineText(context),
          Provider.of<Landinghelpers>(context, listen: false)
              .mainButton(context),
          Provider.of<Landinghelpers>(context, listen: false)
              .privacyText(context)
        ],
      ),
    );
  }

  bodyColor() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.5, 0.9],
          colors: [
            constantColors.darkColor,
            constantColors.blueGreyColor,
          ],
        ),
      ),
    );
  }
}
