import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/repos/auth_repo.dart';
import 'package:zakat/data/repos/wallet_repo.dart';
import 'package:zakat/main.dart';
import 'package:zakat/services/wallet_service.dart';
import 'package:zakat/view/start/login/login_view.dart';

import '../../../data/model/response/base/api_response.dart';
import '../../../utils/app_constants.dart';
import '../../../widgets/custom_dialog.dart';

class SettingsVm extends BaseVm {
  final AuthRepo authRepo = GetIt.I.get<AuthRepo>();
  final WalletRepo walletRepo = GetIt.I.get<WalletRepo>();
  final WalletService walletService = GetIt.I.get<WalletService>();

  String _walletAddress = AppConstants.walletAddress;

  String get walletAddress => _walletAddress;

  set walletAddress(String value) {
    _walletAddress = value;
    notifyListeners();
  }


  Future<void> logOut() async {
    try{
      ApiResponse apiResponse = await authRepo.logout();
      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        await authRepo.clearSharedData();
        await walletService.clearConnectionData();
        Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentState!.context,
          LoginScreen.route,
              (route) => false,
        );
      } else {
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error,
        );
      }
    }catch(e){
      log('Error in logout: $e');
    }
  }

}
