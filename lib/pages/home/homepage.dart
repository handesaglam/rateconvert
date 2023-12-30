import 'package:app/bloc/app_blocs.dart';
import 'package:app/bloc/app_events.dart';
import 'package:app/bloc/app_states.dart';


import 'package:app/pages/home/widgets/other_coins.dart';
import 'package:app/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {

  ExchangeBloc? _restaurantBloc;
  Size? size;


  @override
  Widget build(BuildContext context) {
     _restaurantBloc = BlocProvider.of<ExchangeBloc>(context);
       _restaurantBloc!.add(FetchExchangeEvent());
    size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Material(
            
            
            
            child: Scaffold(
              backgroundColor: kPrimaryColor,
             appBar: AppBar(
              leading: Icon(Icons.menu,
              color: Colors.white,
              
              ),
               
                elevation: 0.0,
                backgroundColor: kPrimaryColor,
                actions: [
             

                ],
              ),
              
              
              body:RefreshIndicator(
                onRefresh: () async{
                  _restaurantBloc!.add(FetchExchangeEvent());
                  await Future.delayed(Duration(seconds: 1));
                },
                child:Container(
                child: BlocListener<ExchangeBloc, ExchangeState>(
                  listener: (context, state) {
                    if (state is ExchangeFailState) {
                      Text(state.message.toString());
                    }
                  },
                  child: BlocBuilder<ExchangeBloc, ExchangeState>(
                    builder: (context, state) {
                      if (state is ExchangeLoadingState) {
                        return CircularProgressIndicator();
                      } else if (state is ExchangeSuccessState) {
                        //    state.restaurantModel!
                        return OtherCoins(
                          rateModel: state.rateModel,

                          
                          
                      );
                      } else if (state is ExchangeFailState) {
                        return Text(state.message.toString());
                      }
                      return Container();
                    },
                  ),
                ),
              ) ,
              )
              
              
       /*  */
            ),
          );
        },
      ),
    );
  }
       
      
      
   
}
