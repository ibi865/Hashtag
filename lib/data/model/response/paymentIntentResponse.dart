class PaymentIntentResponse {
  String? paymentIntentId;
  String? clientSecret;
  double? amount;
  double? amountUsd;
  String? currency;
  String? status;
  String? description;
  String? publishableKey;

  PaymentIntentResponse({
    this.paymentIntentId,
    this.clientSecret,
    this.amount,
    this.amountUsd,
    this.currency,
    this.status,
    this.description,
    this.publishableKey,
  });

  PaymentIntentResponse.fromJson(Map<String, dynamic> json) {
    paymentIntentId = json['paymentIntentId'];
    clientSecret = json['clientSecret'];
    amount = (json['amount'] as num?)?.toDouble();
    amountUsd = (json['amountUsd'] as num?)?.toDouble();
    currency = json['currency'];
    status = json['status'];
    description = json['description'];
    publishableKey = json['publishableKey'];
  }
}
