import 'dart:convert';

import 'package:app/const/appstring.dart';
import 'package:app/models/exchangeRate.dart';
import 'package:http/http.dart' as http;
class RateRepository  {

  @override
  Future<ExchangeRate> getRateData() async {
    final response =  await http.get(Uri.parse(AppStrings.apiUrl));
    if (response.statusCode == 200) {
      List<int> bytes = response.body.toString().codeUnits;
      var responseString = utf8.decode(bytes);
      return ExchangeRate .fromJson(jsonDecode(responseString));
    } else {
 
      throw Exception();
    }
  }

}