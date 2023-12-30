
import 'dart:math';

import 'package:app/ExchangeRate/exchangerate.dart';
import 'package:app/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';



class RateDetail extends StatelessWidget {
  String? moneyunit;
  RateDetail({this.moneyunit});


  final ExchangeRateBloc exchangeRateBloc = ExchangeRateBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        
        appBar: AppBar(
         leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
         ),
            elevation: 0.0,
            backgroundColor: kPrimaryColor,
          
        ),
        body: BlocProvider(
          create: (context) => exchangeRateBloc..add(LoadExchangeRates(selectedDate: DateTime.now(),)),
          child: ExchangeRateWidget(
            unitmoney: moneyunit,
          ),
        ),
      ),
    );
  }
}


class ExchangeRateWidget extends StatelessWidget {

String? unitmoney;
ExchangeRateWidget({this.unitmoney});



    
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExchangeRateBloc, ExchangeRateState>(
      builder: (context, state) {
        List<_SalesData> data = [];

        List<Map<String, double>> tryValues = state.rates.values.toList();

        for (int i = 0; i < tryValues.length; i++) {
          String date = state.rates.keys.elementAt(i);
          double tryValue = tryValues[i]['$unitmoney'] ?? 0.0;
        
          data.add(_SalesData(date, tryValue));
        }

        return Scaffold(
          
          backgroundColor: kPrimaryColor,
          body:  Column(
          children: [
            // DatePicker
            DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                // New date selected
                context.read<ExchangeRateBloc>().add(LoadExchangeRates(selectedDate: date));
              },
            ),
            Container(
            
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.0,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                // Chart title
                title: ChartTitle(text: ''),
                // Enable legend
                legend: Legend(isVisible: true),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<_SalesData, String>>[
                  LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales'+data.length.toString(),
                      // Enable data label
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ],
              ),
            ),
          ],
        ),


        );
      },
    );
  }

  
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}


