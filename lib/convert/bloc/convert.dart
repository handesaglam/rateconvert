import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart'
;
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class CurrencyConverterEvent {}

class ConvertCurrencyEvent extends CurrencyConverterEvent {
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  ConvertCurrencyEvent({
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });
}

// 2. Define states
abstract class CurrencyConverterState {}

class CurrencyConverterInitial extends CurrencyConverterState {}

class CurrencyConvertedState extends CurrencyConverterState {
  final double convertedAmount;

  CurrencyConvertedState({required this.convertedAmount});
}

class CurrencyConverterErrorState extends CurrencyConverterState {}

// 3. Define bloc
class CurrencyConverterBloc extends Bloc<CurrencyConverterEvent, CurrencyConverterState> {
  CurrencyConverterBloc() : super(CurrencyConverterInitial());

  @override
  Stream<CurrencyConverterState> mapEventToState(CurrencyConverterEvent event) async* {
    if (event is ConvertCurrencyEvent) {
      try {
        // Make the API request here
        final response = await http.get(
          Uri.parse(
            'https://api.frankfurter.app/latest?amount=${event.amount}&from=${event.fromCurrency}&to=${event.toCurrency}',
          ),
        );

        // Parse the API response
        final Map<String, dynamic> data = json.decode(response.body);
        final double convertedAmount = data['rates'][event.toCurrency].toDouble();

        yield CurrencyConvertedState(convertedAmount: convertedAmount);
      } catch (e) {
        yield CurrencyConverterErrorState();
      }
    }
  }
  
}