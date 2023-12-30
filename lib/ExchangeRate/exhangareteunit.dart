import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

// ExchangeUnitEvent ve ExchangeUnitState'yi ExchangeUnitBloc içinde tanımlamışsınız, bu kısmı buraya eklemenizi unutmayın
class ExchangeUnitEvent {}

class ExchangeUnitState {
  final Map<String, Map<String, double>> rates;
  final List<String> currencyNames;
  final double convertedAmount;

  ExchangeUnitState({required this.rates, required this.currencyNames, required this.convertedAmount});
}

class ExchangeUnitBloc extends Bloc<ExchangeUnitEvent, ExchangeUnitState> {
  ExchangeUnitBloc() : super(ExchangeUnitState(rates: {}, currencyNames: [], convertedAmount: 0.0));

  @override
Stream<ExchangeUnitState> mapEventToState(ExchangeUnitEvent event) async* {
  try {
    final response = await http.get(
      Uri.parse('https://api.frankfurter.app/latest?amount=100&from=GBP&to=USD'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final Map<String, Map<String, double>> rates = {};
      final List<String> currencyNames = [];

      if (data['rates'] != null && data['rates'] is Map<String, dynamic>) {
        data['rates'].forEach((date, ratesMap) {
          if (ratesMap != null && ratesMap is Map<String, dynamic>) {
            Map<String, double> convertedRatesMap = {};
            ratesMap.forEach((currency, rate) {
              if (rate is double) {
                convertedRatesMap[currency] = rate;
                currencyNames.add(currency);
              } else if (rate is int) {
                convertedRatesMap[currency] = rate.toDouble();
                currencyNames.add(currency);
              }
            });
            rates[date] = convertedRatesMap;
          }
        });
      }

      yield ExchangeUnitState(rates: rates, currencyNames: currencyNames, convertedAmount: 0.0);
    } else {
      // Handle the case where the response status code is not 200
      // You may want to emit an error state or show a message to the user
    }
  } catch (e) {
    // Handle errors, e.g., emit an error state or log the error
    print('Error fetching exchange rates: $e');
  }
}}