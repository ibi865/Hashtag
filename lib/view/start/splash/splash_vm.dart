import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/repos/auth_repo.dart';
import 'package:zakat/main.dart';
import 'package:zakat/utils/shared_preference_keys.dart';
import 'package:zakat/view/bottomNav/bottom_nav.dart';
import 'package:zakat/view/start/importCreateSelection/importCreateSelection_view.dart';
import 'package:zakat/view/start/onboarding/onboarding_view.dart';

class SplashVm extends BaseVm {
  SplashVm(BuildContext context) {
    getSharedPreferencesData();
    initializer(context);
  }
  AuthRepo authRepo = GetIt.I.get<AuthRepo>();

  initializer(BuildContext context) async {
    await Future.delayed(
      const Duration(milliseconds: 3000),
      () => goTo(context),
    );
  }

  getSharedPreferencesData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isKeepUserLogin =
        sharedPreferences.getBool(SharedPreferenceKey.keepSignIn) ?? false;
    isLogin = sharedPreferences.getBool(SharedPreferenceKey.isLogin) ?? false;
    isFirstTime =
        sharedPreferences.getBool(SharedPreferenceKey.isFirstTime) ?? true;
  }

  bool _isKeepUserLogin = false;
  bool get isKeepUserLogin => _isKeepUserLogin;
  set isKeepUserLogin(bool value) {
    _isKeepUserLogin = value;
    notifyListeners();
  }

  bool isFirstTime = true;

  bool _isLogin = false;
  bool get isLogin => _isLogin;
  set isLogin(bool value) {
    _isLogin = value;
    notifyListeners();
  }

  Future<void> goTo(BuildContext context) async {
    if (isLogin && isKeepUserLogin) {
      Navigator.pushNamedAndRemoveUntil(
        navigatorKey.currentState!.context,
        BottomNav.route,
        (route) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        OnboardingView.route,
        (route) => false,
      );
    }
  }
}
