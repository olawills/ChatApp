import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:sociallite/feeds/feeds.dart';
import 'package:sociallite/screens/Chatrooms/chatroom.dart';
import 'package:sociallite/screens/HomePage/homepage_helpers.dart';
import 'package:sociallite/screens/profiles/profile.dart';
import 'package:sociallite/services/authentication/Firebase_operations.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // const HomePage({Key? key}) : super(key: key);
  final ConstantColors constantColors = ConstantColors();
  final PageController homepageController = PageController();
  int pageIndex = 0;

  @override
  void initState() {
    Provider.of<FirebaseOperations>(context, listen: false)
        .initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constantColors.darkColor,
      body: PageView(
        controller: homepageController,
        children: [
          Feeds(),
          ChatRooms(),
          Profiles(),
        ],
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (page) {
          setState(() {
            pageIndex = page;
          });
        },
      ),
      bottomNavigationBar: Provider.of<HomePageHelpers>(context, listen: false)
          .bottomNavBar(context, pageIndex, homepageController),
    );
  }
}
