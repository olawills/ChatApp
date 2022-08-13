import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociallite/screens/landingPage/landing_utils.dart';
import 'package:sociallite/services/authentication/Authentication.dart';

class FirebaseOperations with ChangeNotifier {
  UploadTask? imageUploadTask;
  String initUserEmail = '', initUserName = '', initUserImage = '';
  String? get getInitUserName => initUserName;
  String? get getInitUserEmail => initUserEmail;
  String? get getInitUserImage => initUserImage;

  Future uploaduserAvatar(BuildContext context) async {
    Reference imageReference = FirebaseStorage.instance.ref().child(
        'profilePictures/${Provider.of<LandingUtils>(context, listen: false).getUserAvatar!.path}/${TimeOfDay.now()}');

    imageUploadTask = imageReference.putFile(
        Provider.of<LandingUtils>(context, listen: false).getUserAvatar);
    await imageUploadTask!.whenComplete(() {
      print('Image uploaded');
    });
    imageReference.getDownloadURL().then((url) {
      Provider.of<LandingUtils>(context, listen: false).userAvatarUrl =
          url.toString();
      print(
          'the user profile avatar url => ${Provider.of<LandingUtils>(context, listen: false).userAvatar}');
      notifyListeners();
    });
  }

  Future createUserCollections(BuildContext context, dynamic data) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .set(data);
  }

  Future initUserData(BuildContext context) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<Authentication>(context, listen: false).getUserUid)
        .get()
        .then((doc) {
      print('Fetching user data');
      initUserName = doc.data()['username'];
      initUserEmail = doc.data()['useremail'];
      initUserImage = doc.data()['userimage'];
      print(initUserName);
      print(initUserEmail);
      print(initUserImage);
      notifyListeners();
    });
  }

  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }
}
