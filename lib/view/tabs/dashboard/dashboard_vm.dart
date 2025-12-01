import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/data/model/response/walletBalanceResponse.dart';
import 'package:zakat/data/repos/wallet_repo.dart';
import 'package:zakat/helper/string_helpers.dart';
import 'package:zakat/main.dart';
import 'package:zakat/utils/app_constants.dart';
import 'package:zakat/view/dash_mains/holdList/holdList_view.dart';
import 'package:zakat/view/dash_mains/scanList/scanList_view.dart';
import 'package:zakat/view/dash_mains/zakPay/zakPay_view.dart';
import 'package:zakat/widgets/comingSoon.dart';
import 'package:zakat/widgets/custom_dialog.dart';

import '../../../services/wallet_service.dart';
import '../../../utils/shared_preference_keys.dart';

class DashboardVm extends BaseVm {
  final WalletService walletService = GetIt.instance<WalletService>();
  DashboardVm() {
    initialize();
  }

  late final SharedPreferences _prefs;

  initialize() async {
    _prefs = await SharedPreferences.getInstance();
    AppConstants.systemWalletAddress =
        _prefs.getString(SharedPreferenceKey.systemWalletAddressKey) ?? '';
    getWalletBalance();
  }

  final WalletRepo walletRepo = GetIt.I.get<WalletRepo>();
  String? _zktcBalance;

  String? get zktcBalance => _zktcBalance;

  set zktcBalance(String? value) {
    _zktcBalance = value;
    notifyListeners();
  }

  final List<Map<String, String>> dashboardItems = [
    {"text": "Zak-Pay", "svgPath": "zak".toDashboardPath},
    {"text": "Hold To Give", "svgPath": "give".toDashboardPath},
    {"text": "Scan To Give", "svgPath": ""},
    {"text": "User Triggered Give", "svgPath": "user".toDashboardPath},
    {"text": "Burn To Give", "svgPath": "burn".toDashboardPath},
    {"text": "Deposit", "svgPath": "deposit".toDashboardPath},
  ];
  void handleDashboardItemTap(
    BuildContext context,
    int index,
    String itemText,
  ) {
    switch (index) {
      case 0: // Zak-Pay
        Navigator.pushNamed(context, ZakpayView.route);
        break;
      case 1: // Hold To Give
        Navigator.pushNamed(context, HoldlistView.route);
        break;
      case 2: // Scan To Give
        Navigator.pushNamed(context, ScanlistView.route);
        break;
      case 3: // User Triggered Give
        Navigator.pushNamed(context, Comingsoon.route);
        break;
      case 4: // Burn To Give
        Navigator.pushNamed(context, Comingsoon.route);
        break;
      case 5: // Deposit
        Navigator.pushNamed(context, Comingsoon.route);
        break;
      default:
        debugPrint('Unknown item tapped: $itemText');
    }
  }

  Future<void> getWalletBalance() async {
    if (AppConstants.systemWalletAddress.isEmpty) {
      return;
    }
    try {
      log("system wallet address: ${AppConstants.systemWalletAddress}");
      ApiResponse apiResponse = await walletRepo.getWalletBalance(
        walletAddress: AppConstants.systemWalletAddress,
      );
      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;
        final WalletBalanceResponse response = WalletBalanceResponse.fromJson(
          data,
        );
        if (response.success == true) {
          log('zktc balance: ${response.zktcBalance}');
          zktcBalance = response.zktcBalance;
        }
      } else {
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error ?? 'Something went wrong',
        );
      }
    } catch (e) {
      log('Error in getWalletBalance: $e');
    }
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String? _walletAddress;

  String? get walletAddress => _walletAddress;

  set walletAddress(String? value) {
    _walletAddress = value;
    notifyListeners();
  }

  Future<void> initializeWallet() async {
    try {
      await walletService.initialize();

      // Validate existing session if any
      if (walletService.isConnected) {
        final isValid = await walletService.validateAndRefreshSession();
        if (navigatorKey.currentState!.context.mounted) {
          if (isValid && walletService.isSessionValid()) {
            walletAddress = walletService.connectedAddress;
            customSuccessDialog(
              navigatorKey.currentState!.context,
              "Wallet session restored",
            );
          } else {
            // Session was invalid, clear UI state
            walletAddress = null;
          }
        }
      }
    } catch (e) {
      log("Wallet initialization error: $e");
      if (navigatorKey.currentState!.context.mounted) {
        customErrorDialog(navigatorKey.currentState!.context,"Failed to initialize wallet service");
      }
    }
  }

  void listenToConnectionChanges() {
    walletService.connectionStream.listen((event) {
      if (navigatorKey.currentState!.context.mounted) {
        if (event == 'disconnected') {
          walletAddress = null;
        } else if (event.startsWith('0x')) {
          walletAddress = event;
        }
      }
    });
  }

}
