class ApiEndPoints {
  static const String baseUrl = 'https://dev-api-zakatcoin.kryptomind.net/';

  // Auth Api's
  static const String login = 'auth/login';
  static const String signUp = 'auth/register';
  static const String logout = 'user/logout';

  // Payments
  static const String createPaymentIntent = 'stripe/create-payment-intent';
  static String walletBalance({required String walletAddress}) =>
      'token/zktc-balance/$walletAddress';
  static String getActivity({
    required String page,
    required String limit,
    required String status,
  }) =>
      'payments/dashboard/recent-activity?page=$page&limit=$limit&status=$status';

  static String connectExternalWallet = "wallets/connect-external";
  static String processTokenToWallet = "payments/contract/process-tokens";
  static String disconnectExternalWallet({required String walletAddress}) => "wallets/$walletAddress";
  static String getSystemWalletAddress = "wallets/system-wallet";
  static String getTokenRate = "token-rates/all-rates";
  static String getSupportedTokens = 'token-rates/supported-tokens';
  static String getSingleTokenRate({required String symbol})=> 'token-rates/rate/$Symbol';
  static const String getContractTokenPrice = 'payments/contract/token-price';
  static const String getRemainingDCOSupply = 'payments/contract/remaining-supply';
}
