import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:palflock/module/auth/services/apple/apple_auth.dart';
import 'package:palflock/module/auth/services/facebook/facebook_auth.dart';
import 'package:palflock/module/auth/services/google/google_auth.dart';
import 'package:palflock/utils/navigation_utils/navigation.dart';
import 'package:palflock/utils/navigation_utils/routes.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_string.dart';
import '../../../../utils/constants.dart';
import '../../../bottom_navigation/view/screen/bottom_navigation_screen.dart';
import '../widget/common_button.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImageAssets.appLogoImage).paddingOnly(bottom: Platform.isIOS ? 210.h : 180.h),
                  Platform.isIOS
                      ? CommonButton(
                          btnName: AppString.appleSingIn,
                          onPressed: () {
                            AppleSignInAuth.signInWithApple(context);
                            // Navigation.pushNamed(Routes.locationPermissionScreen);
                          },
                          color: AppColors.black,
                          iconData: ImageAssets.appleImage)
                      : CommonButton(
                          btnName: AppString.googleSingIn,
                          onPressed: () {
                            // Navigation.pushNamed(Routes.locationPermissionScreen);
                            GoogleSignInAuth.signInWithGoogle(context: context);
                          },
                          color: AppColors.googleColor,
                          iconData: ImageAssets.googleImage),
                  CommonButton(
                      btnName: AppString.faceBookSingIn,
                      onPressed: () async {
                        // Navigation.pushNamed(Routes.locationPermissionScreen);
                        //
                        // AuthService;
                        UserCredential? userCredential = await FacebookSignInAuth.signInWithFacebook();
                        print('facebook userCredential==>$userCredential');
                      },
                      color: AppColors.facebookColor,
                      iconData: ImageAssets.facebookImage),
                  CommonButton(
                      btnName: AppString.phoneSingIn,
                      onPressed: () {
                        Navigation.pushNamed(Routes.addMobileNumberScreen);
                      },
                      color: AppColors.phoneColor,
                      iconData: ImageAssets.phoneImage),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: AppColors.black, fontSize: isTab ? 10.sp : 12.sp, fontWeight: FontWeight.w500),
                        children: <TextSpan>[
                          const TextSpan(text: AppString.youAgreeToOur),
                          TextSpan(
                            text: AppString.termsAndPrivacy,
                            style: TextStyle(
                              color: AppColors.black,
                              decoration: TextDecoration.underline,
                              fontSize: isTab ? 10.sp : 12.sp,
                              fontWeight: FontWeight.w700,
                              decorationColor: AppColors.hintColor,
                              // decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                          const TextSpan(text: AppString.learnHowToUseData),
                          TextSpan(
                            text: AppString.privacyPolicy,
                            style: TextStyle(
                              color: AppColors.black,
                              decoration: TextDecoration.underline,
                              fontSize: isTab ? 10.sp : 12.sp,
                              fontWeight: FontWeight.w700,
                              decorationColor: AppColors.hintColor,
                              // decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).paddingAll(24.w),
                ],
              ),
            ),
            Image.asset(
              ImageAssets.backgroundImage,
              gaplessPlayback: true,
            ),
          ],
        ),
      ),
    );
  }

// Widget CommonButton({required String btnName, required void Function() onPressed, required Color color, required String iconData}) {
//   return Bouncing(
//       onPressed: onPressed,
//       child: Container(
//         height: 52.w,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Row(
//           children: [
//             SvgPicture.asset(iconData).paddingAll(14.w),
//             Expanded(
//               child: Text(
//                 btnName,
//                 style: TextStyle(
//                   color: AppColors.white,
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             SvgPicture.asset(ImageAssets.rightArrowImage).paddingAll(14.w),
//           ],
//         ),
//       )).paddingOnly(left: 12.w, right: 12.w, top: 12.w);
// }
}
