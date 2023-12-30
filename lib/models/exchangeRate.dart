class ExchangeRate {
  final double amount;
  final String base;
  final String date;
  final Map<String, double> rates;


  ExchangeRate({
    required this.amount,
    required this.base,
    required this.date,
    required this.rates,
  
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) {
    return ExchangeRate(
      amount: json['amount'].toDouble(),
      base: json['base'],
      date: json['date'],
     
      rates: (json['rates'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, value.toDouble()),
      ),
    );
  }
}