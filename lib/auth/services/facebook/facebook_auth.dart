import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:palflock/utils/navigation_utils/navigation.dart';
import 'package:palflock/utils/navigation_utils/routes.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../utils/loader.dart';
import '../../../../utils/shared_prefrences.dart';
import '../../../mobilescreen/model/user_model.dart';
import '../auth_service.dart';

class FacebookSignInAuth {
  static Future signInWithFacebook() async {
    try {
      UserModel facebookAuthModel = UserModel();
      final LoginResult result = await FacebookAuth.instance.login(permissions: ['email']);
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken?.token ?? '');
          UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);
          if (userCredential.credential?.accessToken != null) {
            facebookAuthModel = await AuthService.getFacebookToken(appleToken: userCredential.credential?.accessToken ?? '');
            removeAppLoader();
            if (facebookAuthModel.accessToken != null) {
              // await StorageHelper.setUserToken(facebookAuthModel.accessToken ?? '');
              await StorageHelper.setUserData(facebookAuthModel,5);
            }
            Permission.location.isGranted == true
                ? Permission.notification.isGranted == true
                    ? facebookAuthModel.data?.isProfileComplete == true
                        ? Navigation.replaceAll(Routes.bottomNavigationBar)
                        : Navigation.pushNamed(Routes.addNameScreen)
                    : Navigation.pushNamed(Routes.notificationPermissionScreen)
                : Navigation.popAndPushNamed(Routes.locationPermissionScreen);
          }
          return userCredential;
        case LoginStatus.cancelled:
          return null;
        case LoginStatus.failed:
          return null;
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }
}

class Resource {
  final Status status;

  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }
