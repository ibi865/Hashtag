import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/model/body/userModel.dart';
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/data/repos/auth_repo.dart';
import 'package:zakat/main.dart';
import 'package:zakat/view/bottomNav/bottom_nav.dart';
import 'package:zakat/view/start/importCreateSelection/importCreateSelection_view.dart';
import 'package:zakat/widgets/custom_dialog.dart';

class LoginVm extends BaseVm {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  LoginVm() {
    if (kDebugMode) {
      emailController.text = 'alpha2@yopmail.com';
      passwordController.text = 'Abcd@1234';
    }
  }
  bool _keepSignIn = true;

  bool get keepSignIn => _keepSignIn;

  set keepSignIn(bool value) {
    _keepSignIn = value;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool hidePassword = true;
  toggleHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  Future<void> login() async {
    isLoading = true;

    try {
      ApiResponse apiResponse = await authRepo.login(
        emailController.text,
        passwordController.text,
      );
      if (apiResponse.response != null &&
              apiResponse.response?.statusCode == 200 ||
          apiResponse.response?.statusCode == 201) {
        isLoading = false;

        authRepo.setUserLoggedIn(
          UserModel.fromJson(apiResponse.response!.data!),
        );
        await authRepo.setUserObject(
          UserModel.fromJson(apiResponse.response!.data!),
        );

        authRepo.setKeepUserSignedIn(keepSignIn);
        authRepo.setFirstTime(false);
        Navigator.pushNamed(
          navigatorKey.currentState!.context,
          BottomNav.route,
        );
        isLoading = false;
      } else {
        isLoading = false;
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error.toString(),
        );
      }
    } catch (e) {
      log('Error occured while logging in : ${e.toString()}');
    }
  }
}
