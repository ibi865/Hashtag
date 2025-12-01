import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/model/response/activityResponse.dart'
    as ActivityResponse;
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/data/model/response/walletBalanceResponse.dart';
import 'package:zakat/data/repos/wallet_repo.dart';
import 'package:zakat/helper/blockChainUrl.dart';
import 'package:zakat/main.dart';
import 'package:zakat/widgets/custom_dialog.dart';

import '../../../utils/app_constants.dart';

class ZakpayVm extends BaseVm {
  ZakpayVm() {
    scrollController.addListener(onScroll);

    Future.wait([getActivity(), getWalletBalance()]);
  }
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();

  bool _isScrollLoading = false;

  bool get isScrollLoading => _isScrollLoading;

  set isScrollLoading(bool value) {
    _isScrollLoading = value;
    notifyListeners();
  }

  int currentPage = 1;
  int limit = 10;
  bool isLastPage = false;

  void onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 100) {
      goToNextPage();
    }
  }

  goToNextPage() {
    log('next page');
    if (isLastPage || isScrollLoading) {
      log('Last page reached or already loading');
      return;
    }
    currentPage++;
    getActivity(moreLoading: true);
  }

  final WalletRepo walletRepo = GetIt.I.get<WalletRepo>();
  List<ActivityResponse.Payments> _activityList = [];

  List<ActivityResponse.Payments> get activityList => _activityList;

  set activityList(List<ActivityResponse.Payments> value) {
    _activityList = value;
    notifyListeners();
  }

  String? _zktcBalance;

  String? get zktcBalance => _zktcBalance;

  set zktcBalance(String? value) {
    _zktcBalance = value;
    notifyListeners();
  }

  launchBlockchainUrls(String blockchain, String hash) async {
    if (hash.isEmpty) return;
    log('data.contractTransactionHash: $hash');
    BlockchainUrlLauncher launcher = BlockchainUrlLauncher(
      blockchain: blockchain,
      hash: hash,
    );
    await launcher.launchBlockchainUrls();
  }

  Future<void> getActivity({bool moreLoading = false}) async {
    if (moreLoading) {
      isScrollLoading = true;
    } else {
      isLoading = true;
    }
    try {
      ApiResponse apiResponse = await walletRepo.getActivity(
        page: currentPage.toString(),
        limit: limit.toString(),
        status: 'all',
      );
      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;
        final ActivityResponse.ActivityResponse response =
            ActivityResponse.ActivityResponse.fromJson(data);
        if (response.data?.payments != null) {
          final list = response.data!.payments!;
          if (moreLoading) {
            activityList.addAll(list);
          } else {
            activityList = list;
          }
        }
        log('total: ${response.data?.pagination?.total}');
        log('currentPage: $currentPage');
        log('limit: $limit');
        if ((response.data?.pagination?.total ?? 0) < (currentPage * limit)) {
          isLastPage = true;
        }
        if (moreLoading) {
          isScrollLoading = false;
        } else {
          isLoading = false;
        }
      } else {
        if (moreLoading) {
          isScrollLoading = false;
        } else {
          isLoading = false;
        }
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error ?? 'Something went wrong',
        );
      }
    } catch (e) {
      if (moreLoading) {
        isScrollLoading = false;
      } else {
        isLoading = false;
      }
      log('Error in getting Activity: $e');
    }
  }

  Future<void> getWalletBalance() async {
    if(AppConstants.systemWalletAddress.isEmpty){
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
          print(response.zktcBalance);
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
}
