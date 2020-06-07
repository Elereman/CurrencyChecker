import 'package:DollarCheck/domain/currency/model/exchange_rate.dart';
import 'package:DollarCheck/meta/exception.dart';

class History {
  final DateTime from;
  final DateTime to;
  final List<ExchangeRate> exchangeRates;

  History(this.exchangeRates, {this.from, this.to});

  History merge(History other) {
    if (from == other.to) {
      return History(
          <ExchangeRate>[...exchangeRates, ...other.exchangeRates]
            ..sort(ExchangeRate.sCompareByTime),
          from: other.from,
          to: to);
    } else if (to == other.from) {
      return History(
          <ExchangeRate>[...exchangeRates, ...other.exchangeRates]
            ..sort(ExchangeRate.sCompareByTime),
          from: other.to,
          to: to);
    } else {
      throw HistoryMergingException(
          <History>[this, other], 'Given history is not adjoins to this');
    }
  }
}

class HistoryMergingException implements DocumentedException {
  @override
  final Object cause;
  @override
  final String message;

  HistoryMergingException(this.cause, this.message);
}
