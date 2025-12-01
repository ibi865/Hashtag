import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat/data/model/body/userModel.dart';
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/utils/api_end_points.dart';
import '../../utils/shared_preference_keys.dart';
import '../dataSource/remote/dio/dio_client.dart';
import '../dataSource/remote/exception/api_error_handler.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({required this.dioClient, required this.sharedPreferences});

  void setKeepUserSignedIn(bool keepSignIn) {
    sharedPreferences.setBool(SharedPreferenceKey.keepSignIn, keepSignIn);
  }
  void setFirstTime(bool isFirstTime) {
    sharedPreferences.setBool(SharedPreferenceKey.isFirstTime, isFirstTime);
  }

  void setUserLoggedIn(UserModel userJson) {
    sharedPreferences.setBool(SharedPreferenceKey.isLogin, true);
    setUserObject(userJson);
  }

  void setUserLogout() {
    sharedPreferences.setBool(SharedPreferenceKey.keepSignIn, false);
    sharedPreferences.setBool(SharedPreferenceKey.isLogin, false);
    sharedPreferences.remove(SharedPreferenceKey.loggedInUserObject);
    _updateToken();
  }

  void _updateToken() {
    dioClient.updateToken();
  }

  Future<void> setUserObject(UserModel userJson) async {
    log(userJson.toString());
    await sharedPreferences.setString(
      SharedPreferenceKey.loggedInUserObject,
      userModelToJson(userJson),
    );
    _updateToken();
  }

  UserModel? getUserObject() {
    if (sharedPreferences.containsKey(SharedPreferenceKey.loggedInUserObject)) {
      return UserModel.fromJson(
        jsonDecode(
          sharedPreferences.getString(SharedPreferenceKey.loggedInUserObject) ??
              "",
        ),
      );
    } else {
      return null;
    }
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(SharedPreferenceKey.isLogin);
    await sharedPreferences.remove(SharedPreferenceKey.loggedInUserObject);
    await sharedPreferences.remove(SharedPreferenceKey.accessToken);
    _updateToken();
    // FirebaseMessaging.instance.unsubscribeFromTopic(AppConstants.TOPIC);
    return true;
  }

  Future<ApiResponse> login(String email, String password) async {
    try {
      Response response = await dioClient.post(
        ApiEndPoints.login,
        data: {"email": email, "password": password, 'fcmToken': ''},
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> signup(UserModel model) async {
    try {
      Response response = await dioClient.post(
        ApiEndPoints.signUp,
        data: model.toSignUpJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> logout() async {
    try {
      Response response = await dioClient.post(
        ApiEndPoints.logout,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
