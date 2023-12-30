import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ExchangeRateEvent {}

class ExchangeRateState {
  final Map<String, Map<String, double>> rates;

  ExchangeRateState({required this.rates});
}

class ExchangeRateBloc extends Bloc<ExchangeRateEvent, ExchangeRateState> {
  ExchangeRateBloc() : super(ExchangeRateState(rates: {}));

  @override
  Stream<ExchangeRateState> mapEventToState(ExchangeRateEvent event) async* {
    if (event is LoadExchangeRates) {
      try {
        String formattedDate = "${event.selectedDate.year}-${event.selectedDate.month}-${event.selectedDate.day}";
DateTime oneDayAgo = event.selectedDate.subtract(Duration(days: 1));

String formattedDateago = "${oneDayAgo.year}-${oneDayAgo.month}-${oneDayAgo.day}";


        final response = await http.get(
          Uri.parse("https://api.frankfurter.app/"+formattedDateago
          
          +".."+formattedDate.toString()),

        );


        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.body);

          final Map<String, Map<String, double>> rates = {};

          if (data['rates'] != null && data['rates'] is Map<String, dynamic>) {
            data['rates'].forEach((date, ratesMap) {
              if (ratesMap != null && ratesMap is Map<String, dynamic>) {
                Map<String, double> convertedRatesMap = {};
                ratesMap.forEach((currency, rate) {
                  if (rate is double) {
                    convertedRatesMap[currency] = rate;
                  } else if (rate is int) {
                    convertedRatesMap[currency] = rate.toDouble();
                  }
                });
                rates[date] = convertedRatesMap;
              }
            });
          }

          yield ExchangeRateState(rates: rates);
        
        }
      } catch (e) {
        // Handle errors
      }
    }
  }
}

class LoadExchangeRates extends ExchangeRateEvent {
  final DateTime selectedDate;

  LoadExchangeRates({required this.selectedDate});
}
