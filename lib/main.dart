import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociallite/constants/Constantcolors.dart';
import 'package:sociallite/feeds/feeds_helpers.dart';
import 'package:sociallite/screens/HomePage/homepage_helpers.dart';
import 'package:sociallite/screens/SplashScreen/splash_screen.dart';
import 'package:sociallite/screens/landingPage/landingHelpers.dart';
import 'package:sociallite/screens/landingPage/landing_services.dart';
import 'package:sociallite/screens/landingPage/landing_utils.dart';
import 'package:sociallite/screens/profiles/profile_helpers.dart';
import 'package:sociallite/services/authentication/Authentication.dart';
import 'package:sociallite/services/authentication/Firebase_operations.dart';
import 'package:sociallite/utils/upload_posts.dart';
import 'package:sociallite/widgets/warning_text.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors constantColors = ConstantColors();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Feedhelpers(),
        ),
        ChangeNotifierProvider(
          create: (_) => UploadPost(),
        ),
        ChangeNotifierProvider(
          create: (_) => WarningText(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileHelpers(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomePageHelpers(),
        ),
        ChangeNotifierProvider(
          create: (_) => LandingUtils(),
        ),
        ChangeNotifierProvider(
          create: (_) => FirebaseOperations(),
        ),
        ChangeNotifierProvider(
          create: (_) => LandingServices(),
        ),
        ChangeNotifierProvider(
          create: (_) => Authentication(),
        ),
        ChangeNotifierProvider(
          create: (_) => Landinghelpers(),
        ),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        title: 'theSocialite',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: constantColors.blueColor,
          ),
          fontFamily: 'Poppins',
          canvasColor: Colors.transparent,
        ),
      ),
    );
  }
}
