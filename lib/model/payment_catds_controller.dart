class PaymentCards {
  final String name;
  final String type;
  final String holderName;
  final String cardNumber;
  final String expirationDate;
  final int securityCode;

  PaymentCards(
      {required this.name,
      required this.type,
      required this.holderName,
      required this.cardNumber,
      required this.expirationDate,
      required this.securityCode});
}
