import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:palflock/module/auth/services/auth_service.dart';
import 'package:palflock/module/chat/services/xmppService.dart';
import 'package:palflock/module/mobilescreen/model/user_model.dart';
import 'package:palflock/utils/loader.dart';
import 'package:palflock/utils/navigation_utils/navigation.dart';
import 'package:palflock/utils/navigation_utils/routes.dart';
import 'package:palflock/utils/shared_prefrences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleSignInAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future signInWithApple(context) async {
    appLoader(context);
    UserModel appleAuthModel = UserModel();
    AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    OAuthCredential oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
    );
    print("signInWithApple oauthCredential ${oauthCredential.token}");
    print("signInWithApple oauthCredential ${appleCredential.identityToken}");
    UserCredential appleUser = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    print('appleUser==>$appleUser');
    if (appleCredential.identityToken != null) {
      appleAuthModel = await AuthService.getAppleToken(appleToken: appleCredential.identityToken);
      removeAppLoader();
      if (appleAuthModel.accessToken != null) {
        // await StorageHelper.setUserToken(appleAuthModel.accessToken ?? '');
        await StorageHelper.setUserData(appleAuthModel,4);
      }
      if (StorageHelper.getUserData(5) != null) {
        XmppService.instance.doConnectXmpp(5);
      }
      StorageHelper.getLocationValue()
          ? StorageHelper.getNotificationValue()
              ? appleAuthModel.data?.isProfileComplete == true
                  ? Navigation.replaceAll(Routes.bottomNavigationBar)
                  : Navigation.pushNamed(Routes.addNameScreen)
              : Navigation.pushNamed(Routes.notificationPermissionScreen)
          : Navigation.popAndPushNamed(Routes.locationPermissionScreen);
    }
  }

  static Future<void> signOutGoogle({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await auth.signOut();
    } catch (e) {}
  }
}
