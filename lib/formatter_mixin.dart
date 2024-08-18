mixin FormatterMixin {
  String formatRate(double rate) {
    return '\$${rate.toStringAsFixed(2)}';
  }

  String formatDate(String date) {
    return DateTime.parse(date).toLocal().toString().split(' ')[0];
  }
}
