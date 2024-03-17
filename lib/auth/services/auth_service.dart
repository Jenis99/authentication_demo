import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:palflock/dio_service/dio_instant.dart';
import 'package:palflock/utils/api_constant.dart';

import '../../../utils/app_exception.dart';
import '../../mobilescreen/model/user_model.dart';

class AuthService {
  static Future<UserModel> getGoogleToken({String? googleToken}) async {
    try {
      var result = await AuthDio.instance.get(
        "${ApiConstants.googleLogin}/$googleToken",
      );
      return UserModel.fromJson(result.data);
    } catch (exception, s) {
      log("exception in getGoogleToken : E $exception , $s");
      throw AppException(message: "Something went wrong", errorCode: 0);
      // throw AppException.exceptionHandler(exception);
    }
  }

  static Future<UserModel> getAppleToken({String? appleToken}) async {
    try {
      var result = await AuthDio.instance.get(
        "${ApiConstants.appleLogin}$appleToken",
      );
      // return AppleLoginModel.fromJson(jsonDecode(result.body));
      return UserModel.fromJson(result.data);
    } catch (exception, s) {
      debugPrint("exception in getAppleToken : E $exception , $s");
      throw AppException(message: "Something went wrong", errorCode: 0);
    }
  }

  static Future<UserModel> getFacebookToken({String? appleToken}) async {
    try {
      var result = await AuthDio.instance.get(
        "${ApiConstants.facebookLogin}$appleToken",
      );
      // return AppleLoginModel.fromJson(jsonDecode(result.body));
      return UserModel.fromJson(result.data);
    } catch (exception, s) {
      debugPrint("exception in getAppleToken : E $exception , $s");
      throw AppException(message: "Something went wrong", errorCode: 0);
    }
  }
}
