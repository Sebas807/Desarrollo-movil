class ExchangeRate {
  final String currency;
  final String date;
  final double rate;

  ExchangeRate({
    required this.currency,
    required this.date,
    required this.rate,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      currency: json['unidad'] ?? '',
      date: json['vigenciadesde'] ?? '',
      rate: double.tryParse(json['valor'] ?? '0') ?? 0.0,
    );
  }
}
