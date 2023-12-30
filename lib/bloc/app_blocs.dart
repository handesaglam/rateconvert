import 'package:app/bloc/app_events.dart';
import 'package:app/bloc/app_states.dart';
import 'package:app/data/repository/exchangeRate_respository.dart';
import 'package:app/models/exchangeRate.dart';


import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';


class ExchangeBloc extends Bloc<ExchangeEvent, ExchangeState> {

  RateRepository? rateRepository;

  ExchangeBloc({@required this.rateRepository}) : super(ExchangeLoadingState());

  ExchangeState get initialState => ExchangeLoadingState();

  @override
  Stream<ExchangeState> mapEventToState(ExchangeEvent event) async* {
    if (event is FetchExchangeEvent) {
      yield ExchangeLoadingState();
      try {
        ExchangeRate rateModel = await rateRepository!.getRateData();
        print("Bloc Success");
        yield ExchangeSuccessState(rateModel: rateModel);
      } catch (e) {
        print(  await rateRepository!.getRateData());
        yield ExchangeFailState(message: "???");
      }
    }
  }
}