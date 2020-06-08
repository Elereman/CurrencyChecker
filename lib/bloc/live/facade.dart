import 'package:DollarCheck/domain/currency/model/broker/broker.dart';
import 'package:DollarCheck/domain/currency/model/broker/rate_publisher.dart';
import 'package:DollarCheck/domain/currency/model/currency.dart';
import 'package:DollarCheck/domain/currency/model/exchange_rate.dart';
import 'package:DollarCheck/domain/media/logo/logo.dart';

class LiveFacade {
  Stream<List<ExchangeRate>> observeFavoriteRates() async* {
    yield* Stream<List<ExchangeRate>>.periodic(
        const Duration(seconds: 5),
        (int _) => <ExchangeRate>[
              ExchangeRate(
                  Currency('USD', 'United States Dollar'),
                  ExchangeBroker(
                      'Broker full name',
                      const Logo(
                          'https://devlaz.ru/wp-content/uploads/2016/04/23.gif')),
                  RatePublisher(
                      'https://github.com/',
                      const Logo(
                          'https://devlaz.ru/wp-content/uploads/2016/04/23.gif')),
                  id: 1,
                  buy: 30,
                  sell: 20,
                  timestamp: DateTime.now())
            ]);
  }

  Future<List<ExchangeRate>> getFavoriteRates() async {
    return <ExchangeRate>[
      ExchangeRate(
          Currency('USD', 'United States Dollar'),
          ExchangeBroker(
              'Broker full name',
              const Logo(
                  'https://devlaz.ru/wp-content/uploads/2016/04/23.gif')),
          RatePublisher(
              'https://github.com/',
              const Logo(
                  'https://devlaz.ru/wp-content/uploads/2016/04/23.gif')),
          id: 1,
          buy: 30,
          sell: 20,
          timestamp: DateTime.now())
    ];
  }
}
