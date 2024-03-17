import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as authUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palflock/module/auth/services/auth_service.dart';
import 'package:palflock/module/chat/services/xmppService.dart';
import 'package:palflock/utils/loader.dart';
import 'package:palflock/utils/navigation_utils/navigation.dart';
import 'package:palflock/utils/navigation_utils/routes.dart';

import '../../../../utils/shared_prefrences.dart';
import '../../../mobilescreen/model/user_model.dart';

class GoogleSignInAuth {
  static authUser.FirebaseAuth auth = authUser.FirebaseAuth.instance;

  static Future<authUser.User?> signInWithGoogle({required BuildContext context}) async {
    authUser.User? user;

    UserModel googleAuthModel = UserModel();
    appLoader(context);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      await googleSignIn.signOut();
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      print('credential==>${googleAuth.idToken}');
      log("token----- ${googleAuth.idToken ?? ""}");
      print("token----- ${googleAuth.idToken ?? ""}");
      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      UserCredential userCredential = await auth.signInWithCredential(credential).whenComplete(() async {
        if (googleAuth.idToken != null) {
          googleAuthModel = await AuthService.getGoogleToken(googleToken: googleAuth.idToken);
          removeAppLoader();
          if (googleAuthModel.accessToken != null) {
            // await StorageHelper.setUserToken(googleAuthModel.accessToken ?? '');
            await StorageHelper.setUserData(googleAuthModel,6);
            if (StorageHelper.getUserData(20) != null) {
              XmppService.instance.doConnectXmpp(4);
            }
          }
          if (StorageHelper.getLocationValue()) {
            if (StorageHelper.getNotificationValue()) {
              if (googleAuthModel.data?.isProfileComplete == true) {
                Navigation.popAndPushNamed(Routes.bottomNavigationBar);
              } else {
                Navigation.pushNamed(Routes.addNameScreen);
              }
            } else {
              Navigation.pushNamed(Routes.notificationPermissionScreen);
            }
          } else {
            Navigation.popAndPushNamed(Routes.locationPermissionScreen);
          }


          // StorageHelper.getLocationValue()
          //     ? StorageHelper.getNotificationValue()
          //         ? googleAuthModel.data?.isProfileComplete == true
          //             ? Navigation.popAndPushNamed(Routes.bottomNavigationBar)
          //             : Navigation.pushNamed(Routes.addNameScreen)
          //         : Navigation.pushNamed(Routes.notificationPermissionScreen)
          //     : Navigation.popAndPushNamed(Routes.locationPermissionScreen);
        }
      });
    } catch (e) {
      log(e.toString());
      removeAppLoader();
    }
    return user;
  }
}
