import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/model/body/userModel.dart';
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/data/repos/auth_repo.dart';
import 'package:zakat/main.dart';
import 'package:zakat/widgets/custom_dialog.dart';

class SignupVm extends BaseVm {
  final AuthRepo authRepo = GetIt.I.get<AuthRepo>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void toggleHidePassword() {
    hidePassword = !hidePassword;
    notifyListeners();
  }

  Future<void> signup() async {
    isLoading = true;
    try {
      UserModel model = UserModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        userName: userNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      ApiResponse apiResponse = await authRepo.signup(model);

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        isLoading = false;
        Navigator.pop(navigatorKey.currentState!.context);
        customSuccessDialog(
          navigatorKey.currentState!.context,
          apiResponse.response!.data['message'],
        );
      } else {
        isLoading = false;
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error?.toString() ?? "Signup failed",
        );
      }
    } catch (e) {
      isLoading = false;
      log("Error during signup: $e");
      customErrorDialog(
        navigatorKey.currentState!.context,
        "Something went wrong, please try again",
      );
    } finally {
      isLoading = false;
    }
  }
}
