import 'package:app/models/exchangeRate.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ExchangeState extends Equatable {
  @override
  List<Object> get props => [];
}

class ExchangeLoadingState extends ExchangeState {

}

class ExchangeSuccessState extends ExchangeState {

  final ExchangeRate? rateModel;

 ExchangeSuccessState({@required this.rateModel});

  @override
  // TODO: implement props
  List<Object> get props => [rateModel!];
}

class ExchangeFailState extends ExchangeState {

  final String? message;

  ExchangeFailState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message!];
}