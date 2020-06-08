import 'package:DollarCheck/domain/currency/model/broker/broker.dart';
import 'package:DollarCheck/domain/currency/model/broker/rate_publisher.dart';
import 'package:DollarCheck/domain/currency/model/currency.dart';

class ExchangeRate {
  final int id;
  final double buy;
  final double sell;
  final Currency currency;
  final ExchangeBroker broker;
  final RatePublisher publisher;
  final DateTime timestamp;

  const ExchangeRate(this.currency, this.broker, this.publisher,
      {this.id, this.buy, this.sell, this.timestamp});

  static int sCompareByTime(ExchangeRate first, ExchangeRate other) =>
      first.timestamp.compareTo(other.timestamp);
}
