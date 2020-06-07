import 'package:DollarCheck/domain/currency/model/exchange_rate.dart';
import 'package:DollarCheck/domain/currency/model/history.dart';
import 'package:DollarCheck/domain/currency/model/currency.dart';
import 'package:DollarCheck/domain/currency/model/time_gap.dart';

abstract class ExchangeCourseHistoryService {
  void recordExchangeCourse(ExchangeRate course);

  Future<History> getHistory(Currency currency, TimeGap gap);
}
