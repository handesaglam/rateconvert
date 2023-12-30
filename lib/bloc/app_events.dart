import 'package:equatable/equatable.dart';

abstract class ExchangeEvent extends Equatable{

  @override
  List<Object> get props =>[];
}

class FetchExchangeEvent extends ExchangeEvent {}