import 'dart:convert';

import 'package:app/convert/bloc/convert.dart';
import 'package:app/models/exchangeRate.dart';
import 'package:app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:numpad/numpad.dart';

import '../../../ExchangeRate/exhangareteunit.dart';




class MyApp23 extends StatelessWidget {
    final ExchangeRate? rate;
    MyApp23({this.rate});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => CurrencyConverterBloc(),
        child: DovizCevirici(
          rate: rate,

        ),
      ),
    );
  }
}



class DovizCevirici extends StatefulWidget {
  final ExchangeRate? rate;

  DovizCevirici({this.rate});
  
  @override
  _DovizCeviriciState createState() => _DovizCeviriciState();
}

class _DovizCeviriciState extends State<DovizCevirici> {

   String _fromSelected = "USD";
  String _toSeleceted = "TRY";
   double convertedAmount = 0.0;
  
  String code = "";

  TextEditingController amountController = TextEditingController();




  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      backgroundColor: kPrimaryColor, // Change this to your desired primary color
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0.0,
        title: Text('Döviz Çevirici'),
      ),
      body: Container(
            child: BlocBuilder<CurrencyConverterBloc, CurrencyConverterState>(
              builder: (context, state) {
                if (state is CurrencyConvertedState) {
                  double convertedAmount = state.convertedAmount;
                  return Text('Converted Amount: $convertedAmount',
                  style: TextStyle(color: Colors.white),
                  
                  );
                } else if (state is CurrencyConverterErrorState) {
                  return Text('Error during conversion.');
                } else {
                  return Container(
                    child: Column(
            children: [


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

            
                 Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white, width: 0.80),
                ),
                child: DropdownButton<String>(
                  value: _fromSelected,
                  items: widget.rate?.rates.keys
                      .map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      })
                      .toList() ??
                      [],
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromSelected = newValue ?? '';
                    });
                  },
                ),
              ),

   Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.white, width: 0.80),
                ),
                child: DropdownButton<String>(
                  value: _toSeleceted,
                  items: widget.rate?.rates.keys
                      .map((String currency) {
                        return DropdownMenuItem<String>(
                          value: currency,
                          child: Text(currency),
                        );
                      })
                      .toList() ??
                      [],
                  onChanged: (String? newValue) {
                    setState(() {
                      _toSeleceted= newValue ?? '';
                    });
                  },
                ),
              ),



              Container(

              ),
              
               GestureDetector(
                onTap: (){

     double amount = double.tryParse(amountController.text) ?? 0.0;
                // Döviz çevirme işlemi için yeni event'i tetikle
                context.read<CurrencyConverterBloc>().add(
                      ConvertCurrencyEvent(
                        fromCurrency: _fromSelected,
                        toCurrency: _toSeleceted,
                        amount: amount,
                      ),
                    );


                },
child:  Container(
                  child: Text("Çevir"),


                ),

               )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(20),
                child: TextField(
                  onChanged: (String deger) {
                    print('TextFieldden gelen değer onChanged: ' + '$deger');
                  },
                  onSubmitted: (String deger) {
                    print('TextFieldden gelen değer onSubmitted: ' + '$deger');
                  },
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 20,),

               Container(
                child: BlocBuilder<CurrencyConverterBloc, CurrencyConverterState>(
              builder: (context, state) {
                if (state is CurrencyConvertedState) {
                  double convertedAmount = state.convertedAmount;
                  return Text('Converted Amount: $convertedAmount');
                } else if (state is CurrencyConverterErrorState) {
                  return Text('Error during conversion.');
                } else {
                  return Container(); // Initial state
                }
              },
            ),
               )

 


              // The rest of your code...
            ],
          ),
                  ); // Initial state
                }
              },
            ),
          ),


      
          );
        
      
    
  }

}