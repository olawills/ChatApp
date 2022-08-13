import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:sociallite/screens/HomePage/HomePage.dart';
import 'package:sociallite/screens/landingPage/landing_utils.dart';
import 'package:sociallite/services/authentication/Authentication.dart';
import 'package:sociallite/services/authentication/Firebase_operations.dart';
import 'package:sociallite/widgets/email_widget.dart';
import 'package:sociallite/widgets/password_widget.dart';
import 'package:sociallite/widgets/warning_text.dart';

class LandingServices with ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ConstantColors constantColors = ConstantColors();

  showUserAvatar(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                CircleAvatar(
                  radius: 80.0,
                  backgroundColor: constantColors.transperant,
                  backgroundImage: FileImage(
                      Provider.of<LandingUtils>(context, listen: false)
                          .userAvatar!),
                ),
                Container(
                  child: Row(
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Provider.of<LandingUtils>(context, listen: false)
                              .pickUserAvatar(context, ImageSource.gallery);
                        },
                        child: Text(
                          'Reselect',
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            decorationColor: constantColors.whiteColor,
                          ),
                        ),
                      ),
                      MaterialButton(
                        color: constantColors.blueColor,
                        onPressed: () {
                          Provider.of<FirebaseOperations>(context,
                                  listen: false)
                              .uploaduserAvatar(context)
                              .whenComplete(() {
                            signUpSheet(context);
                          });
                        },
                        child: Text(
                          'Confirm Image',
                          style: TextStyle(
                            color: constantColors.whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  // This widget is for passwordless sigin for when the users already has an account

  Widget passwordLessSiginIn(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.map(
                (DocumentSnapshot documentSnapshot) {
                  var data = documentSnapshot.data();
                  print(data);
                  return ListTile(
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.trashCan,
                        color: constantColors.redColor,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: constantColors.transperant,
                      backgroundImage:
                          NetworkImage(documentSnapshot.data()['userimage']),
                    ),
                    subtitle: Text(
                      documentSnapshot.data()['useremail'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColors.greenColor,
                        fontSize: 12.0,
                      ),
                    ),
                    title: Text(
                      documentSnapshot.data()['username'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: constantColors.greenColor,
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          }
        },
      ),
    );
  }

  // This is a login sheet that pulls up from the bottom using showlModalBottomSheet

  logInSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: constantColors.blueGreyColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    thickness: 4.0,
                    color: constantColors.whiteColor,
                  ),
                ),
                EmailWidget(
                    emailController: emailController,
                    constantColors: constantColors),
                PasswordWidget(
                    passwordController: passwordController,
                    constantColors: constantColors),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: () {
                    if (emailController.text.isNotEmpty) {
                      Provider.of<Authentication>(context, listen: false)
                          .loginIntoAccount(
                              emailController.text, passwordController.text)
                          .whenComplete(() {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: HomePage(),
                            type: PageTransitionType.bottomToTop,
                          ),
                        );
                      });
                    } else {
                      Provider.of<WarningText>(context, listen: false)
                          .warningText(context, 'Fill all the boxes');
                      //warningText(context, 'Fill all the boxes');
                    }
                  },
                  color: constantColors.blueColor,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: constantColors.whiteColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

// This sheet shows a signUp form for new users..
  signUpSheet(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: constantColors.blueGreyColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: constantColors.whiteColor,
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: FileImage(
                        Provider.of<LandingUtils>(context, listen: false)
                            .getUserAvatar!),
                    backgroundColor: constantColors.redColor,
                    radius: 60.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: TextField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        hintText: 'Enter name...',
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
                  ),
                  EmailWidget(
                      emailController: emailController,
                      constantColors: constantColors),
                  PasswordWidget(
                      passwordController: passwordController,
                      constantColors: constantColors),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: MaterialButton(
                      onPressed: () {
                        if (emailController.text.isNotEmpty) {
                          Provider.of<Authentication>(context, listen: false)
                              .createNewAccount(
                                  emailController.text, passwordController.text)
                              .whenComplete(() {
                            print('Creating collections...');
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .createUserCollections(context, {
                              'useruid': Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid,
                              'useremail': emailController.text,
                              'username': userNameController.text,
                              'userimage': Provider.of<LandingUtils>(context,
                                      listen: false)
                                  .getUserAvatarUrl,
                            });
                          }).whenComplete(() {
                            print('Creating collection.....');
                            Provider.of<FirebaseOperations>(context,
                                    listen: false)
                                .createUserCollections(context, {
                              'useruid': Provider.of<Authentication>(context,
                                      listen: false)
                                  .getUserUid,
                              'useremail': emailController.text,
                              'username': userNameController.text,
                              'userimage': Provider.of<LandingUtils>(context,
                                      listen: false)
                                  .getUserAvatarUrl,
                            });
                          }).whenComplete(() {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                child: HomePage(),
                                type: PageTransitionType.bottomToTop,
                              ),
                            );
                          });
                        } else {
                          Provider.of<WarningText>(context, listen: false)
                              .warningText(context, 'Fill all the boxes');
                          //warningText(context, 'Fill all the boxes');
                        }
                      },
                      color: constantColors.blueColor,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: constantColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
