import 'package:ejercicio2/exchange_rate_service.dart';

void main() async {
  final apiUrl =
      'https://www.datos.gov.co/resource/32sa-8pi3.json'; // URL de la API
  final exchangeRateService = ExchangeRateService(apiUrl: apiUrl);

  try {
    final rates = await exchangeRateService.fetchExchangeRates();
    final statistics = exchangeRateService.calculateStatistics(rates);
    print('Exchange Rate Statistics: ');
    print(exchangeRateService.formatExchangeRateStatistics(statistics));
  } catch (e) {
    print('Error: $e');
  }
}
