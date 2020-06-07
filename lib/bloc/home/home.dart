import 'package:DollarCheck/domain/currency/model/exchange_rate.dart';
import 'package:DollarCheck/meta/bloc.dart';
import 'package:built_collection/built_collection.dart';

class LiveBloc extends Bloc<LiveState, _InitLiveEvent> {
  LiveBloc() : super();
}

class LiveState with BlocState {
  final BuiltList<ExchangeRate> rates;

  @override
  final Object error;
  @override
  final BlocStatus status;

  LiveState(this.error, this.status, this.rates);
}

class _InitLiveEvent implements BlocEvent<LiveState> {
  @override
  LiveState reduce(LiveState state) {
    throw UnimplementedError();
  }
}
