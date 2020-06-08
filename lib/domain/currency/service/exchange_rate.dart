import 'package:DollarCheck/domain/currency/model/exchange_rate.dart';

abstract class ExchangeCourseService {
  Future<List<ExchangeRate>> getRates();
}
