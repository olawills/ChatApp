import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:sociallite/feeds/feeds_helpers.dart';

class Feeds extends StatelessWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return Scaffold(
      backgroundColor: constantColors.blueGreyColor,
      drawer: Drawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Provider.of<Feedhelpers>(context, listen: false).appBar(context),
      ),
      body: Provider.of<Feedhelpers>(context, listen: false).feedBody(context),
    );
  }
}
