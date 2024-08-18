import 'package:ejercicio2/exchange_rate_service.dart';

void main() async {
  final apiUrl =
      'https://www.datos.gov.co/resource/32sa-8pi3.json'; // URL de la API
  final exchangeRateService = ExchangeRateService(apiUrl: apiUrl);

  try {
    final rates = await exchangeRateService.fetchExchangeRates();
    final statistics = exchangeRateService.calculateStatistics(rates);

    print('Exchange Rate Statistics:');
    print('Value at Start of Year:');
    print('Currency: ${statistics.startOfYearRate.currency}');
    print(
        'Date: ${exchangeRateService.formatDate(statistics.startOfYearRate.date)}');
    print(
        'Rate: ${exchangeRateService.formatRate(statistics.startOfYearRate.rate)}');

    print('\nLowest Value:');
    print('Currency: ${statistics.minRate.currency}');
    print('Date: ${exchangeRateService.formatDate(statistics.minRate.date)}');
    print('Rate: ${exchangeRateService.formatRate(statistics.minRate.rate)}');

    print('\nHighest Value:');
    print('Currency: ${statistics.maxRate.currency}');
    print('Date: ${exchangeRateService.formatDate(statistics.maxRate.date)}');
    print('Rate: ${exchangeRateService.formatRate(statistics.maxRate.rate)}');

    print('\nCurrent Value:');
    print('Currency: ${statistics.currentRate.currency}');
    print(
        'Date: ${exchangeRateService.formatDate(statistics.currentRate.date)}');
    print(
        'Rate: ${exchangeRateService.formatRate(statistics.currentRate.rate)}');
  } catch (e) {
    print('Error: $e');
  }
}
