import 'dart:convert';
import 'package:http/http.dart' as http;
import 'formatter_mixin.dart';
import 'exchange_rate.dart';

class ExchangeRateService with FormatterMixin {
  final String apiUrl;

  ExchangeRateService({required this.apiUrl});

  Future<List<ExchangeRate>> fetchExchangeRates() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);

      if (json.isNotEmpty) {
        return json.map((item) {
          return ExchangeRate.fromJson(item as Map<String, dynamic>);
        }).toList();
      } else {
        throw Exception('No data available');
      }
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  ExchangeRateStatistics calculateStatistics(List<ExchangeRate> rates) {
    final now = DateTime.now();
    final startOfYear = DateTime(now.year, 1, 1);

    final ratesFromStartOfYear = rates.where((rate) {
      final date = DateTime.parse(rate.date);
      return date.isAfter(startOfYear) || date.isAtSameMomentAs(startOfYear);
    }).toList();

    final minRate =
        ratesFromStartOfYear.reduce((a, b) => a.rate < b.rate ? a : b);
    final maxRate =
        ratesFromStartOfYear.reduce((a, b) => a.rate > b.rate ? a : b);

    final startOfYearRate = ratesFromStartOfYear.isNotEmpty
        ? ratesFromStartOfYear.reduce((a, b) {
            final dateA = DateTime.parse(a.date);
            final dateB = DateTime.parse(b.date);
            return (dateA.isBefore(startOfYear) ? startOfYear : dateA)
                        .difference(startOfYear)
                        .abs() <
                    (dateB.isBefore(startOfYear) ? startOfYear : dateB)
                        .difference(startOfYear)
                        .abs()
                ? a
                : b;
          })
        : minRate;

    final currentRate = ratesFromStartOfYear.isNotEmpty
        ? ratesFromStartOfYear.reduce((a, b) {
            final dateA = DateTime.parse(a.date);
            final dateB = DateTime.parse(b.date);
            return dateA.difference(now).abs() < dateB.difference(now).abs()
                ? a
                : b;
          })
        : minRate;

    return ExchangeRateStatistics(
      minRate: minRate,
      maxRate: maxRate,
      startOfYearRate: startOfYearRate,
      currentRate: currentRate,
    );
  }

  String formatExchangeRateStatistics(ExchangeRateStatistics statistics) {
    return '''
    Value at Start of Year:
    Currency: ${statistics.startOfYearRate.currency}
    Date: ${formatDate(statistics.startOfYearRate.date)}
    Rate: ${formatRate(statistics.startOfYearRate.rate)}

    Lowest Value:
    Currency: ${statistics.minRate.currency}
    Date: ${formatDate(statistics.minRate.date)}
    Rate: ${formatRate(statistics.minRate.rate)}

    Highest Value:
    Currency: ${statistics.maxRate.currency}
    Date: ${formatDate(statistics.maxRate.date)}
    Rate: ${formatRate(statistics.maxRate.rate)}

    Current Value:
    Currency: ${statistics.currentRate.currency}
    Date: ${formatDate(statistics.currentRate.date)}
    Rate: ${formatRate(statistics.currentRate.rate)}
    ''';
  }
}

class ExchangeRateStatistics {
  final ExchangeRate minRate;
  final ExchangeRate maxRate;
  final ExchangeRate startOfYearRate;
  final ExchangeRate currentRate;

  ExchangeRateStatistics({
    required this.minRate,
    required this.maxRate,
    required this.startOfYearRate,
    required this.currentRate,
  });
}
