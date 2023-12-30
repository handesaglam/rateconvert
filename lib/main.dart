import 'package:app/bloc/app_blocs.dart';
import 'package:app/bloc/app_states.dart';
import 'package:app/data/repository/exchangeRate_respository.dart';
import 'package:app/pages/home/widgets/convert_rate.dart';
import 'package:app/language/LanguageCubit.dart';
import 'package:app/pages/rate_detail/rate_detail.dart';
import 'package:app/pages/home/homepage.dart';

import 'package:app/splash.dart';
import 'package:app/utils/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize:  Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
         
          // You can use the library anywhere in the app even in theme
         
          home: child,
        );
      },
      child: BlocProvider(
  create: (context) => LanguageCubit(),
  child: BlocBuilder<LanguageCubit, Locale>(
    builder: (context, locale) {
      return MaterialApp(
        home: BlocProvider(
        create: (context) => ExchangeBloc(rateRepository: RateRepository()),
        child: HomePage (),
      ),
        locale: locale,
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
           const Locale('tr', ''),
          // Add other supported locales
        ],
        localizationsDelegates: [
          // Your localization delegates
          // For example, AppLocalizations.delegate
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        // Other MaterialApp properties

        
      );

      
    },
    
  ),

  
)


      
    );
    
    
    
  }

  
}