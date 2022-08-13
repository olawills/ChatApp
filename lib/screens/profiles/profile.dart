import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:sociallite/screens/profiles/profile_helpers.dart';
import 'package:sociallite/services/authentication/Authentication.dart';
import 'package:sociallite/widgets/profile_title_widget.dart';

class Profiles extends StatelessWidget {
  const Profiles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConstantColors constantColors = ConstantColors();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            EvaIcons.settings2Outline,
            color: constantColors.lightBlueColor,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              EvaIcons.logOutOutline,
              color: constantColors.greenColor,
            ),
            onPressed: () {
              Provider.of<ProfileHelpers>(context, listen: false)
                  .logOutDialog(context);
            },
          )
        ],
        backgroundColor: constantColors.blueGreyColor.withOpacity(0.4),
        title: ProfileTitleWidget(
          constantColors: constantColors,
          title1: 'My ',
          title2: 'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: constantColors.blueGreyColor.withOpacity(0.6),
            ),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(Provider.of<Authentication>(context, listen: false)
                      .getUserUid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .headerProfile(
                        context,
                        snapshot.data as DocumentSnapshot,
                      ),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .divider(),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .middleProfile(context, snapshot),
                      Provider.of<ProfileHelpers>(context, listen: false)
                          .footerProfile(context, snapshot),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
