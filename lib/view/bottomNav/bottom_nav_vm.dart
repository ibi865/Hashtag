import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/data/repos/wallet_repo.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/view/tabs/dashboard/dashboard_view.dart';
import 'package:zakat/view/tabs/dashboard/dashboard_vm.dart';
import 'package:zakat/view/tabs/settings/settings_view.dart';
import 'package:zakat/view/tabs/settings/settings_vm.dart';
import 'package:zakat/widgets/comingSoon.dart';
import 'package:zakat/widgets/custom_button.dart';
import 'package:zakat/widgets/custom_text.dart';

import '../../main.dart';
import '../../services/wallet_service.dart';
import '../../utils/app_constants.dart';
import '../../utils/constant_imports.dart';
import '../../utils/shared_preference_keys.dart';
import '../../widgets/custom_dialog.dart';

class BottomNavVm extends BaseVm {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    if (_selectedIndex == value) return;
    _selectedIndex = value;
    notifyListeners();
  }

  final WalletService walletService = GetIt.instance<WalletService>();

  final WalletRepo walletRepo = GetIt.I.get<WalletRepo>();
  late final SharedPreferences _prefs;
  BottomNavVm() {
    initializeWallet();
    getSystemWalletAddress();
    listenToConnectionChanges();
  }

  String? _walletAddress;

  String? get walletAddress => _walletAddress;

  set walletAddress(String? value) {
    _walletAddress = value;
    notifyListeners();
  }

  Future<void> initializeWallet() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      await walletService.initialize();

      // Validate existing session if any
      if (walletService.isConnected) {
        final isValid = await walletService.validateAndRefreshSession();
        if (navigatorKey.currentState!.context.mounted) {
          if (isValid && walletService.isSessionValid()) {
            walletAddress = walletService.connectedAddress;
            AppConstants.walletAddress = walletService.connectedAddress ?? '';
            AppConstants.systemWalletAddress =
                _prefs.getString(SharedPreferenceKey.systemWalletAddressKey) ??
                '';
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
        customErrorDialog(
          navigatorKey.currentState!.context,
          "Failed to initialize wallet service",
        );
      }
    }
  }

  Future<void> getSystemWalletAddress() async {
   
    try {
      ApiResponse apiResponse = await walletRepo.getSystemWalletAddress();
      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;
        AppConstants.systemWalletAddress = data['data']['systemWallet']['walletAddress'];
        log("system wallet address: ${AppConstants.systemWalletAddress}");
        await _prefs.setString(
          SharedPreferenceKey.systemWalletAddressKey,
          data['data']['systemWallet']['walletAddress'],
        );
      } else {
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error ?? 'Something went wrong',
        );
      }
    } catch (e) {
      log('Error in getSystemWalletAddress: $e');
    }
  }

  void listenToConnectionChanges() {
    walletService.connectionStream.listen((event) {
      if (navigatorKey.currentState!.context.mounted) {
        if (event == 'disconnected') {
          walletAddress = null;
        } else if (event.startsWith('0x')) {
          // New connection
          walletAddress = event;
        }
      }
    });
  }

  List<String> donationsList = [
    'Hold to Give',
    'Scan to Give',
    'User triggered Give',
    'Burn to Give',
  ];

  final List<Widget> pages = [
    ChangeNotifierProvider(
      create: (context) => DashboardVm(),
      child: const DashboardView(),
    ),
    Comingsoon(showbackButton: false),
    SizedBox.shrink(),
    Comingsoon(showbackButton: false),
    ChangeNotifierProvider(
      create: (context) => SettingsVm(),
      child: const SettingsView(),
    ),
  ];

  showDonationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "DONATIONS",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: donationsList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        if (donationsList[index] == 'User triggered Give') {
                          Navigator.pop(context);
                          showTriggeredBottomSheet(context);
                        }
                      },
                      title: CustomText(
                        text: donationsList[index],
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.grey,
                      ),
                    );
                  },
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  borderRadius: 12.r,
                  buttonColor: AppColors.btnColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> triggeredList = [
    'Acquisition based Giving',
    'Convert to Pay',
    'Sell to Pay',
  ];

  showTriggeredBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "User triggered Give",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: triggeredList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: CustomText(
                        text: triggeredList[index],
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: AppColors.grey,
                      ),
                    );
                  },
                ),
                CustomButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  text: 'Cancel',
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  borderRadius: 12.r,
                  buttonColor: AppColors.btnColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
