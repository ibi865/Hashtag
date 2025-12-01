import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zakat/data/dataSource/remote/dio/dio_client.dart';
import 'package:zakat/data/dataSource/remote/exception/api_error_handler.dart';
import 'package:zakat/data/model/body/paymentIntentBody.dart';
import 'package:zakat/data/model/response/base/api_response.dart';
import 'package:zakat/utils/api_end_points.dart';

class WalletRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  WalletRepo({required this.dioClient, required this.sharedPreferences});
  Future<ApiResponse> createPaymentIntent(PaymentIntentBody model) async {
    try {
      Response response = await dioClient.post(
        ApiEndPoints.createPaymentIntent,
        data: model.toJson(),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getWalletBalance({required String walletAddress}) async {
    try {
      Response response = await dioClient.get(
        ApiEndPoints.walletBalance(walletAddress: walletAddress),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getActivity({
    required String page,
    required String limit,
    required String status,
  }) async {
    try {
      Response response = await dioClient.get(
        ApiEndPoints.getActivity(page: page, limit: limit, status: status),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> connectExternalWallet({
    required String walletAddress,
    required String provider,
    required String walletType,
  }) async {
    try {
      Response response = await dioClient.post(
        ApiEndPoints.connectExternalWallet,
        data: {
          'walletAddress': walletAddress,
          'provider': provider,
          'walletType': walletType,
        },
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> processTokensToWallet({
    required String walletAddress,
    required double donationPercentage,
    required double usdAmount,
    required String x_wallet_nonce,
    required String x_wallet_signature,
  }) async {
    try {
      Response response = await dioClient.post(
        ApiEndPoints.processTokenToWallet,
        data: {
          'walletAddress': walletAddress,
          'usdAmount': usdAmount,
          'donationPercentage': donationPercentage,
        },
        options: Options(
          headers: {
            'x-wallet-nonce': x_wallet_nonce,
            'x-wallet-signature': x_wallet_signature,
          },
        ),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> disconnectExternalWallet({
    required String walletAddress,
  }) async {
    try {
      Response response = await dioClient.delete(
        ApiEndPoints.disconnectExternalWallet(walletAddress: walletAddress),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSystemWalletAddress() async {
    try {
      Response response = await dioClient.get(
        ApiEndPoints.getSystemWalletAddress,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getTokenRates() async {
    try {
      Response response = await dioClient.get(ApiEndPoints.getTokenRate);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSupportedTokens() async {
    try {
      Response response = await dioClient.get(ApiEndPoints.getSupportedTokens);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSingleTokenPrice({required String symbol}) async {
    try {
      Response response = await dioClient.get(
        ApiEndPoints.getSingleTokenRate(symbol: symbol),
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getContractTokenPrice() async {
    try {
      Response response = await dioClient.get(
        ApiEndPoints.getContractTokenPrice,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  Future<ApiResponse> getRemainingDCOSupply() async {
    try {
      Response response = await dioClient.get(
        ApiEndPoints.getRemainingDCOSupply,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
