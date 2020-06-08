import 'dart:async';

import 'package:DollarCheck/bloc/live/facade.dart';
import 'package:DollarCheck/domain/currency/model/exchange_rate.dart';
import 'package:DollarCheck/meta/bloc.dart';
import 'package:built_collection/built_collection.dart';

class LiveBloc extends Bloc<LiveState, BlocEvent<LiveState>> {
  final LiveFacade _facade;

  StreamSubscription<List<ExchangeRate>> _ratesUpdateSubscription;

  LiveBloc(this._facade) {
    eventSink.add(_InitLiveEvent(eventSink, _facade.getFavoriteRates));
    _ratesUpdateSubscription =
        _facade.observeFavoriteRates().listen((List<ExchangeRate> rates) {
      eventSink.add(_RatesUpdatedEvent(rates));
    });
  }

  void refresh() {
    eventSink.add(_InitLiveEvent(eventSink, _facade.getFavoriteRates));
  }

  @override
  void dispose() {
    super.dispose();
    _ratesUpdateSubscription?.cancel();
  }
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
  final Future<List<ExchangeRate>> Function() _getExchangeRates;
  final Sink<BlocEvent<LiveState>> _sink;

  _InitLiveEvent(this._sink, this._getExchangeRates);

  @override
  LiveState reduce(LiveState state) {
    _getExchangeRates()
        .then(
            (List<ExchangeRate> rates) => _sink.add(_RatesUpdatedEvent(rates)))
        .catchError(
            (Object error) => _sink.add(_RatesUpdateFailedEvent(error)));
    return LiveState(null, BlocStatus.processing, state.rates);
  }
}

class _RatesUpdatedEvent implements BlocEvent<LiveState> {
  final List<ExchangeRate> _rates;

  _RatesUpdatedEvent(this._rates);

  @override
  LiveState reduce(LiveState state) {
    final Set<ExchangeRate> rates = _rates.toSet()..addAll(state.rates);
    return LiveState(null, BlocStatus.idle, rates.toBuiltList());
  }
}

class _RatesUpdateFailedEvent implements BlocEvent<LiveState> {
  final Object error;

  _RatesUpdateFailedEvent(this.error);

  @override
  LiveState reduce(LiveState state) {
    return LiveState(error, BlocStatus.idle, null);
  }
}
