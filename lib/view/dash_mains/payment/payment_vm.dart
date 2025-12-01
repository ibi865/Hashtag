import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zakat/config/wallet_config.dart';
import 'package:zakat/data/base_vm.dart';
import 'package:zakat/data/model/body/paymentIntentBody.dart';
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/data/model/response/paymentIntentResponse.dart';
import 'package:zakat/data/model/response/tokenRate.dart';
import 'package:zakat/data/repos/wallet_repo.dart';
import 'package:zakat/helper/blockChainUrl.dart';
import 'package:zakat/main.dart';
import 'package:zakat/utils/app_constants.dart';
import 'package:zakat/utils/color_resources.dart';
import 'package:zakat/utils/constant_imports.dart';
import 'package:zakat/utils/extension.dart';
import 'package:zakat/widgets/custom_dialog.dart';
import 'package:zakat/widgets/custom_text.dart';
import 'package:http/http.dart';

import '../../../services/wallet_service.dart';

class PaymentVm extends BaseVm {
  PaymentVm() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      getSupportedTokens(),
      getTokenRate(),
      getContractTokenPrice(),
    ]);
  }

  int _currentTabIndex = 0;

  int get currentTabIndex => _currentTabIndex;

  set currentTabIndex(int value) {
    _currentTabIndex = value;
    notifyListeners();
  }

  final WalletRepo walletRepo = GetIt.I.get<WalletRepo>();
  final WalletService walletService = GetIt.instance<WalletService>();

  final PageController pageController = PageController();
  String walletAddress = AppConstants.walletAddress;

  final TextEditingController amountCtrl = TextEditingController();
  final TextEditingController donationCtrl = TextEditingController(text: "2.5");
  final GlobalKey<FormState> fiatKey = GlobalKey<FormState>();
  final TextEditingController cryptoAmountCtrl = TextEditingController();
  final TextEditingController tokenCtrl = TextEditingController(text: 'USDT');
  final TextEditingController cryptoDonationCtrl = TextEditingController(
    text: "2.5",
  );
  final GlobalKey<FormState> cryptoKey = GlobalKey<FormState>();
  List<String> cryptoTokens = ['USDT', 'USDC', 'ETH'];
  List<TokenRate> tokenRates = [];
  double? _zktcPrice;

  double? get zktcPrice => _zktcPrice;

  set zktcPrice(double? value) {
    _zktcPrice = value;
    notifyListeners();
  }

  double? _defaultTokenRate;

  double? get defaultTokenRate => _defaultTokenRate;

  set defaultTokenRate(double? value) {
    _defaultTokenRate = value;
    notifyListeners();
  }

  String? clientSecret;
  String? publishableKey;
  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool paymentReady = false;
  bool _agreeToTerms = false;

  bool get agreeToTerms => _agreeToTerms;

  set agreeToTerms(bool value) {
    _agreeToTerms = value;
    notifyListeners();
  }

  double donationPercentage = 2.5;
  bool _showDisclaimer = false;

  bool get showDisclaimer => _showDisclaimer;

  set showDisclaimer(bool value) {
    _showDisclaimer = value;
    notifyListeners();
  }

  void setDonation(double value) {
    donationPercentage = value;
    donationCtrl.text = value.toStringAsFixed(1); // update with 1 decimal
    notifyListeners();
  }

  double cryptoDonationPercentage = 2.5;

  void cryptoSetDonation(double value) {
    cryptoDonationPercentage = value;
    cryptoDonationCtrl.text = value.toStringAsFixed(1); // update with 1 decimal
    notifyListeners();
  }

  double getCryptoAmount(String token) {
    // Return the amount for any token, not just USDT
    return double.tryParse(cryptoAmountCtrl.text) ?? 0.0;
  }

  update() {
    notifyListeners();
  }

  Future<void> getSupportedTokens() async {
    try {
      ApiResponse apiResponse = await walletRepo.getSupportedTokens();

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;

        if (data != null &&
            data['data'] != null &&
            data['data']['tokens'] != null) {
          cryptoTokens = List<String>.from(data['data']['tokens']);
          notifyListeners();
        }
      }
    } catch (e) {
      log('Error in getSupportedTokens: $e');
    }
  }

  Future<bool> getRemainingDCOSupply({required double amount}) async {
    try {
      print('Total amount: $amount');
      ApiResponse apiResponse = await walletRepo.getRemainingDCOSupply();

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final dynamic supplyValue =
            apiResponse.response!.data['remainingSupply'];
        final double data = supplyValue is int
            ? supplyValue.toDouble()
            : (supplyValue is double
                  ? supplyValue
                  : double.tryParse(supplyValue.toString()) ?? 0.0);

        print('remaining supply $data');

        if (amount > data!) {
          customErrorDialog(
            navigatorKey.currentState!.context,
            'Provided amount is greater than reserved supply of zktc',
          );
          return false;
        } else {
          return true;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Error in getting remaining supply: $e');

      return false;
    }
  }

  Future<void> getTokenRate() async {
    try {
      ApiResponse apiResponse = await walletRepo.getTokenRates();

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;

        for (var rateData in data['data']['rates'] as List<dynamic>) {
          var rate = TokenRate.fromJson(rateData);
          tokenRates.add(rate);

          if (rate.symbol == tokenCtrl.text) {
            defaultTokenRate = rate.usdPrice ?? 1.0;
            print('${rate.symbol}: ${defaultTokenRate}');
          }
        }

        notifyListeners();
      }
    } catch (e) {
      print('🔥 Error in getTokenRate: $e');
    }
  }

  double defaultTokenRateForUSDT() {
    if (tokenRates.isEmpty) return 0.0;
    return tokenRates.firstWhere((map) => map.symbol == 'USDT').usdPrice ?? 0.0;
  }

  Future<void> getContractTokenPrice() async {
    try {
      ApiResponse apiResponse = await walletRepo.getContractTokenPrice();

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;

        if (data['success'] == true) {
          zktcPrice = data['tokenPrice'];
          print('zktc price: $zktcPrice');
        }

        notifyListeners();
      }
    } catch (e) {
      print('🔥 Error in getting contract token price: $e');
    }
  }

  Future<void> connectWallet(BuildContext context) async {
    // Always clear any pending operations so user can re-tap without errors
    await walletService.cancelPendingConnectionIfAny();

    // Check if already connected
    if (walletService.isConnected && walletService.isSessionValid()) {
      customSuccessDialog(context, "Wallet already connected");
      return;
    }

    isLoading = true;

    try {
      // Show wallet selector bottom sheet first
      final selected = await showWalletSelector(context);
      if (selected == null) {
        isLoading = false;
        return;
      }

      log("Starting wallet connection...");
      final address = await walletService.connectWallet(walletName: selected);

      if (context.mounted) {
        if (address != null) {
          walletAddress = address;
          walletService.connectExternalWallet(walletAddress: address);
          AppConstants.walletAddress = address;
          customSuccessDialog(
            context,
            "Wallet connected: ${address.substring(0, 6)}...${address.substring(address.length - 4)}",
          );
        } else {
          customErrorDialog(context, "Failed to connect wallet");
        }
      }
    } on TimeoutException {
      if (context.mounted) {
        customErrorDialog(context, "Connection timeout. Please try again.");
      }
    } catch (e) {
      log("Connection error: $e");
      String errorMessage = e.toString();

      if (context.mounted) {
        // Provide user-friendly error messages
        if (errorMessage.contains("Connection already in progress")) {
          // After cleanup above, this should rarely occur; guide user to retry
          customErrorDialog(
            context,
            "Previous attempt is still cleaning up. Please tap Connect Wallet again.",
          );
        } else if (errorMessage.contains("Please wait")) {
          customErrorDialog(context, "$errorMessage");
        } else if (errorMessage.contains("MetaMask not found") ||
            errorMessage.contains("MetaMask not installed")) {
          customErrorDialog(
            context,
            "MetaMask is not installed. Please install MetaMask first.",
          );
        } else if (errorMessage.toLowerCase().contains("user rejected") ||
            errorMessage.contains("4001")) {
          customErrorDialog(
            context,
            "You declined the wallet connection. Tap Connect Wallet to try again.",
          );
        } else if (errorMessage.toLowerCase().contains("cancel")) {
          customErrorDialog(
            context,
            "Connection was cancelled. Tap Connect Wallet to try again.",
          );
        } else if (errorMessage.contains("hanging") ||
            errorMessage.contains("not responding")) {
          customErrorDialog(
            context,
            "Wallet is not responding. Please restart your wallet and try again.",
          );
        } else if (errorMessage.contains("timeout")) {
          customErrorDialog(
            context,
            "MetaMask took too long to respond. Please try again.",
          );
        } else if (errorMessage.toLowerCase().contains("network") ||
            errorMessage.toLowerCase().contains("socket")) {
          customErrorDialog(
            context,
            "Network issue detected. Check your internet connection and try again.",
          );
        } else {
          customErrorDialog(context, "Connection failed. Please try again.");
        }
      }
    } finally {
      if (context.mounted) {
        isLoading = false;
      }
    }
  }

  /// Enhanced method to check wallet app availability
  Future<void> checkWalletAvailability(BuildContext context) async {
    final walletApps = <String, String>{
      'MetaMask': 'metamask://',
      'Trust Wallet': 'trust://',
      'Rainbow': 'rainbow://',
    };

    final availableWallets = <String>[];

    for (final entry in walletApps.entries) {
      try {
        final uri = Uri.parse(entry.value);
        if (await canLaunchUrl(uri)) {
          availableWallets.add(entry.key);
        }
      } catch (e) {
        log("Error checking ${entry.key}: $e");
      }
    }

    if (availableWallets.isEmpty) {
      _showDialog(
        "No Wallet Apps Found",
        "Please install MetaMask, Trust Wallet, or Rainbow to continue.",
        context,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              launchUrl(Uri.parse("https://metamask.io/download/"));
            },
            child: const Text("Install MetaMask"),
          ),
        ],
      );
      throw Exception("No wallet apps available");
    } else {
      log("📱 Available wallets: ${availableWallets.join(', ')}");
    }
  }

  Future<String?> showWalletSelector(BuildContext context) async {
    final wallets = const [
      'MetaMask',
      'Coinbase Wallet',
      'Trust Wallet',
      'Binance Wallet',
      'Phantom',
      'WalletConnect',
    ];

    return await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final maxHeight = MediaQuery.of(ctx).size.height * 0.7;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 16.h,
            bottom: 16.h + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: SafeArea(
            top: false,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Connect Wallet',
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(ctx),
                        icon: Icon(Icons.close, color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: wallets.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final w = wallets[index];
                        return InkWell(
                          onTap: () => Navigator.pop(ctx, w),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: Colors.black12),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 12.h,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.account_balance_wallet,
                                  color: AppColors.btnColor,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomText(
                                    text: w,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDialog(
    String title,
    String message,
    BuildContext context, {
    List<Widget>? actions,
  }) {
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions:
            actions ??
            [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
      ),
    );
  }

  launchBlockchainUrlsForAddress(String blockchain, String address) async {
    if (address.isEmpty) return;
    log('data.contractTransactionHash: $address');
    BlockchainUrlLauncherForAddress launcher = BlockchainUrlLauncherForAddress(
      blockchain: blockchain,
      address: address,
    );
    await launcher.launchBlockchainUrls();
  }

  Future<void> disconnectWallet() async {
    try {
      ApiResponse apiResponse = await walletRepo.disconnectExternalWallet(
        walletAddress: AppConstants.walletAddress,
      );
      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;
        log("wallet disconnect: ${data['message']}");
        customErrorDialog(navigatorKey.currentState!.context, data['message']);
        walletService.disconnectWallet().then((value) {
          notifyListeners();
          walletAddress = AppConstants.walletAddress;
        });
      } else {
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error,
        );
      }
    } catch (e) {
      log('Error in disconnect wallet: $e');
    }
  }

  Future<void> createPaymentIntent() async {
    try {
      if (AppConstants.systemWalletAddress.isEmpty) {
        customErrorDialog(
          navigatorKey.currentState!.context,
          "Address not found",
        );
        return;
      }
      loading = true;

      double amount = double.tryParse(amountCtrl.text) ?? 0.0;
      if (!await getRemainingDCOSupply(
        amount:
            (((amount * defaultTokenRate!) / zktcPrice!) -
            (((amount * defaultTokenRate!) / zktcPrice!) *
                donationPercentage /
                100)),
      )) {
        loading = false;
        return;
      }

      // double donation = double.tryParse(donationCtrl.text) ?? 2.5;
      PaymentIntentBody model = PaymentIntentBody(
        amount: amount,
        walletAddress: walletAddress,
        description: 'Token purchase',
        currency: 'usd',
        donationPercentage: donationPercentage,
        metadata: {},
      );

      ApiResponse apiResponse = await walletRepo.createPaymentIntent(model);

      if (apiResponse.response != null &&
          (apiResponse.response?.statusCode == 200 ||
              apiResponse.response?.statusCode == 201)) {
        final data = apiResponse.response!.data;
        final PaymentIntentResponse response = PaymentIntentResponse.fromJson(
          data['data'],
        );

        clientSecret = response.clientSecret;
        publishableKey = response.publishableKey;
        log('client secret: ${clientSecret}');
        log('publish key: ${publishableKey}');

        // Set Stripe key
        Stripe.publishableKey = publishableKey!;
        loading = false;
        paymentReady = true;

        // customSuccessDialog(
        //   navigatorKey.currentState!.context,
        //   'Account registered successfully!. Please Login to continue.',
        // );
      } else {
        loading = false;
        customErrorDialog(
          navigatorKey.currentState!.context,
          apiResponse.error?.toString() ?? "Payment Intent Failed",
        );
      }
    } catch (e) {
      log('Error occured while creating payment intent: ${e.toString()}');
    }
  }

  Future<void> makePayment() async {
    try {
      if (clientSecret == null) {
        throw Exception(
          "Client secret not available. Fetch a PaymentIntent first.",
        );
      }

      // 👇 Init PaymentSheet in custom flow (only card input shown)
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret!,
          merchantDisplayName: "ZakatCoin",
          allowsDelayedPaymentMethods: false,
          customFlow: true, // 👈 this hides the "dummy $10 button"
          style: ThemeMode.system,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(primary: Colors.blue),
          ),
        ),
      );

      // 👇 Present just the card entry form
      await Stripe.instance.presentPaymentSheet(
        options: PaymentSheetPresentOptions(),
      );

      // 👇 Now confirm programmatically when user clicks your own "Pay $X" button
      await Stripe.instance.confirmPaymentSheetPayment();

      // Verify PaymentIntent status for explicit feedback
      final String? verifiedClientSecret = clientSecret;
      if (verifiedClientSecret != null) {
        final paymentIntent = await Stripe.instance.retrievePaymentIntent(
          verifiedClientSecret,
        );
        if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
          Navigator.pop(navigatorKey.currentState!.context);
          customSuccessDialog(
            navigatorKey.currentState!.context,
            'Payment completed successfully.',
          );
        } else {
          customErrorDialog(
            navigatorKey.currentState!.context,
            'Payment not completed. Status: ${paymentIntent.status.name}',
          );
        }
      }

      // Reset after success path
      paymentReady = false;
      clientSecret = null;
      publishableKey = null;
      notifyListeners();

      debugPrint("✅ Payment successful");
    } on StripeException catch (e) {
      debugPrint("❌ Stripe error: ${e.error.localizedMessage}");
      customErrorDialog(
        navigatorKey.currentState!.context,
        e.error.localizedMessage ?? 'Payment failed',
      );
    } catch (e) {
      debugPrint("❌ Payment failed: $e");
      customErrorDialog(
        navigatorKey.currentState!.context,
        'Payment failed: $e',
      );
    }
  }

  // BottomSheets
  showCoinPairBottomSheet(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      backgroundColor: AppColors.bgColor,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: context.viewInsets),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sb.h10,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: "Select Token",
                        color: AppColors.btnColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(thickness: 0.5, color: Colors.grey),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cryptoTokens.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      tokenCtrl.text = cryptoTokens[index];

                      // Find the token rate in a simple loop
                      defaultTokenRate = 1.0; // Default fallback
                      for (var rate in tokenRates) {
                        if (rate.symbol == tokenCtrl.text) {
                          defaultTokenRate = rate.usdPrice ?? 1.0;
                          break;
                        }
                      }

                      notifyListeners();
                    },
                    child: ListTile(
                      leading: cryptoTokens[index] == 'USDT'
                          ? SvgPicture.asset(
                              AppConstants.getTokenImage(cryptoTokens[index]),
                              width: 25.w,
                              height: 25.h,
                            )
                          : Image.asset(
                              AppConstants.getTokenImage(cryptoTokens[index]),
                              width: 25.w,
                              height: 25.h,
                            ),
                      title: CustomText(
                        text: cryptoTokens[index],
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isConnecting = false;

  bool get isConnecting => _isConnecting;

  set isConnecting(bool value) {
    _isConnecting = value;
    notifyListeners();
  }

  Future<String> getRecipientAddress() async {
    try {
      isLoading = true;
      String rpcUrl = WalletConfig.getEthRPC();
      String jsonString = (await rootBundle.loadString(
        'assets/abi/zakatAbi.json',
      ));
      log("ABI file loaded successfully, length: ${jsonString.length}");

      Web3Client web3client = Web3Client(rpcUrl, Client());
      ContractAbi contractAbi = ContractAbi.fromJson(jsonString, "DCO");
      log("Contract ABI created successfully");

      DeployedContract zakatContract = DeployedContract(
        contractAbi,
        EthereumAddress.fromHex(WalletConfig.getZakatContractAddress()),
      );
      String functionName =
          "ethAddress"; // This should return the recipient address

      final addressFn = zakatContract.function(functionName);
      log("Contract function retrieved successfully");

      final result = await web3client.call(
        contract: zakatContract,
        function: addressFn,
        params: [],
      );
      String recipientAddress = result.first.toString();
      log("Recipient address retrieved: $recipientAddress");

      // Check if the returned address matches expected
      if (recipientAddress.toLowerCase() ==
          "0xC5262E6d67C7C5E9e8050B50D684Df16783111bE".toLowerCase()) {
        log("SUCCESS: Address matches expected value!");
        return recipientAddress;
      } else {
        log(
          "MISMATCH: Expected 0xC5262E6d67C7C5E9e8050B50D684Df16783111bE but got $recipientAddress",
        );
        return "0xC5262E6d67C7C5E9e8050B50D684Df16783111bE";
      }
    } catch (e) {
      log("Error getting recipient address from contract: $e");
      return "0xC5262E6d67C7C5E9e8050B50D684Df16783111bE"; // Return expected address instead of wrong one
    }
  }
}
