// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// class LoginController extends GetxController {
//   static LoginController get to => Get.find();
//
//   Rx<GoogleAuthModel> signInModel = GoogleAuthModel().obs;
//   Rx<AppleLoginModel> appleSignInModel = AppleLoginModel().obs;
//   RxBool isLoginLoader = false.obs;
//
//   // Future<void> googleAuthUser({String? googleToken}) async {
//   //   try {
//   //     isLoginLoader.value = true;
//   //     log("response.user?.isLogin---->${googleToken}");
//   //     signInModel.value = await AuthService.getGoogleToken(googleToken: googleToken);
//   //
//   //     log("response 00 ---->${signInModel.toJson()}");
//   //     await AppPrefService.setUserEmail(userEmail: signInModel.value.user?.email ?? "");
//   //     if (signInModel.value.status == 200) {
//   //       await AppPrefService.setUserToken(userToken: signInModel.value.accessToken ?? "");
//   //       if (signInModel.value.user?.isVerify == true) {
//   //         log("response.user?.isLogin 00 ---->${signInModel.value.user?.email}");
//   //         Get.find<VerifyPhoneController>().emailAddress = signInModel.value.user?.email;
//   //         log("response.user?.isLogin---->${signInModel.value.user?.email}");
//   //         if (signInModel.value.user?.isPart1 == true && signInModel.value.user?.isPart2 == true && signInModel.value.user?.isPart3 == true) {
//   //           Get.offAllNamed(Routes.dashBoardScreen);
//   //         } else if (signInModel.value.user?.isPart1 == false) {
//   //           Get.offAllNamed(Routes.welcomeScreen);
//   //         } else if (signInModel.value.user?.isPart2 == false) {
//   //           Get.offAllNamed(Routes.qualificationScreen);
//   //         } else if (signInModel.value.user?.isPart3 == false) {
//   //           Get.offAllNamed(Routes.socialDetailsScreen);
//   //         }
//   //       } else {
//   //         // log("response.user?.isLogin-else--->${response.user?.isLogin}");
//   //         // AppSnackBar.showErrorSnackBar(message: response.message ?? "", title: response.user?.email ?? "");
//   //         // Get.offAllNamed(Routes.accountSetUpScreen);
//   //       }
//   //     } else {
//   //       // AppSnackBar.showErrorSnackBar(message: response.message ?? "", title: response.message ?? "");
//   //     }
//   //   } catch (e) {
//   //     log("Exception in googleAuthUser---->$e");
//   //   } finally {
//   //     isLoginLoader.value = false;
//   //   }
//   // }
//
//   Future<void> appleLoginUser({String? appleToken}) async {
//     try {
//       isLoginLoader.value = true;
//       appleSignInModel.value = await AuthService.getAppleToken(appleToken: appleToken);
//       debugPrint("appleLoginUser-appleToken--->$appleToken");
//       await AppPrefService.setUserEmail(userEmail: appleSignInModel.value.user?.email ?? "");
//       if (appleSignInModel.value.status == 200) {
//         if (appleSignInModel.value.user?.isVerify ?? false) {
//           log("response.user?.isLogin 00 ---->${appleSignInModel.value.user?.email}");
//           Get.find<VerifyPhoneController>().emailAddress = appleSignInModel.value.user?.email;
//           log("response.user?.isLogin---->${appleSignInModel.value.user?.email}");
//           if ((appleSignInModel.value.user?.isPart1 ?? false) && (appleSignInModel.value.user?.isPart2 ?? false) && (appleSignInModel.value.user?.isPart3 ?? false)) {
//             Get.offAllNamed(Routes.dashBoardScreen);
//           } else if (!(appleSignInModel.value.user?.isPart1 ?? false)) {
//             Get.offAllNamed(Routes.welcomeScreen);
//           } else if (!(appleSignInModel.value.user?.isPart2 ?? false)) {
//             Get.offAllNamed(Routes.qualificationScreen);
//           } else if (!(appleSignInModel.value.user?.isPart3 ?? false)) {
//             Get.offAllNamed(Routes.socialDetailsScreen);
//           }
//         } else {
//           // log("response.user?.isLogin-else--->${response.user?.isLogin}");
//           // AppSnackBar.showErrorSnackBar(message: response.message ?? "", title: response.user?.email ?? "");
//           // Get.offAllNamed(Routes.accountSetUpScreen);
//         }
//       } else {
//         // AppSnackBar.showErrorSnackBar(message: response.message ?? "", title: response.message ?? "");
//       }
//     } catch (e) {
//       debugPrint("Exception in appleLoginUser---->$e");
//     } finally {
//       isLoginLoader.value = false;
//     }
//   }
// }
