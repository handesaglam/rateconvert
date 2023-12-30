
import 'package:app/ExchangeRate/exchangerate.dart';
import 'package:app/ExchangeRate/exhangareteunit.dart';
import 'package:app/bloc/app_blocs.dart';
import 'package:app/bloc/app_states.dart';
import 'package:app/pages/home/widgets/convert_rate.dart';

import 'package:app/models/exchangeRate.dart';
import 'package:app/pages/rate_detail/rate_detail.dart';


import 'package:app/utils/adaptive_height_extension.dart';
import 'package:app/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class OtherCoins extends StatefulWidget {
  final ExchangeRate? rateModel;

  OtherCoins({this.rateModel});

  @override
  _OtherCoinsState createState() => _OtherCoinsState();
}

class _OtherCoinsState extends State<OtherCoins> {
  int editableIndex = -1; // Düzenlenebilir olan index
  TextEditingController editingController = TextEditingController();
    final ExchangeRateBloc exchangeRateBloc = ExchangeRateBloc();
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),

     
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [



        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

GestureDetector(
  onTap: (){

    print("*---");
  

 Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
 ConvertRate (
  rate: widget.rateModel,
 )));

  },
  child: Container(
  height: 25,
child: Image.asset("assets/images/ok.png",
color: Colors.white,

),

)

)



          ],
        ),


         SizedBox(height: 15.0),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.rateModel!.rates.length,
            itemBuilder: (BuildContext context, int index) {
              String currencyCode = widget.rateModel!.rates.keys.elementAt(index);
              double rate = widget.rateModel!.rates[currencyCode] ?? 0.0;

              return GestureDetector(
                onTap: () {
                //  print("---"+widget.restaurantModel!);
                  
                 //CoinDetail
          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  RateDetail (

            moneyunit:currencyCode
            //rate: widget.rateModel,

          )));
 
                
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 50.0.h,
                  color: Color.fromRGBO(55, 66, 92, 0.4),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: Row(
                    children: [




if( currencyCode=="AUD")...[
Container(
  height: 30,
child:   Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Australia_%28converted%29.svg/400px-Flag_of_Australia_%28converted%29.svg.png")
,

)

]else if(currencyCode=="BGN")...[
  
Container(
  height: 30,
child:   Image.network("https://i-invdn-com.investing.com/news/LYNXNPED871JG_M.jpg")
,

)

]else if(currencyCode=="BRL")...[

Container(
  height: 30,
child:   Image.network("https://ideacdn.net/shop/ac/77/myassets/products/260/pr_01_260.jpg?revision=1697143329")
,

)

]else if(currencyCode=="CAD")...[
  Container(
  height: 30,
child:   Image.network("https://e1.pxfuel.com/desktop-wallpaper/674/448/desktop-wallpaper-belgium-flag-widescreen-86228-belgian-flag.jpg")
,

)

]else if(currencyCode=="CHF")...[

  Container(
  height: 30,
child:   Image.network("https://flagpedia.net/data/flags/w1600/ch.png")
,

)

]else if(currencyCode=="CNY")...[
  Container(
  height: 30,
child:   Image.network("https://flagpedia.net/data/flags/w1600/cn.png")
,

)


]else if(currencyCode=="CZK")...[
   Container(
  height: 30,
child:   Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_Czech_Republic.svg/1280px-Flag_of_the_Czech_Republic.svg.png")
,

)


]


else...[
  Container(
    height: 30,
   // child: Image.asset("assets/"),


  )


],



                      SizedBox(
                        width: 20.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          
                          Text(
                            '$currencyCode: $rate',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18
                            ),
                          ),


 Text(
                            widget.rateModel!.amount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                           
                            ),
                          ),





                        
                        ],
                      ),
                     
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    ),


    );
  }
}