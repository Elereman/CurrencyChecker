import 'dart:convert';
import 'dart:io';

import 'package:DollarCheck/domain/currency/model/broker/broker.dart';
import 'package:DollarCheck/domain/currency/model/broker/rate_publisher.dart';
import 'package:DollarCheck/domain/currency/model/currency.dart';
import 'package:DollarCheck/domain/currency/model/exchange_rate.dart';
import 'package:DollarCheck/domain/currency/service/exchange_rate.dart';
import 'package:DollarCheck/domain/media/logo/logo.dart';

class MinfinHtmlParsingRestExchangeService implements ExchangeCourseService {
  @override
  Future<List<ExchangeRate>> getRates() async {
    String htmlResponse = '';
    const String url =
        'https://minfin.com.ua/currency/auction/usd/buy/kharkov/';
    final HttpClient client = HttpClient();
    final HttpClientRequest request = await client.getUrl(Uri.parse(url));
    final HttpClientResponse requestResponse = await request.close();
    await for (final String contents
        in requestResponse.transform(const Utf8Decoder())) {
      htmlResponse = htmlResponse + contents;
    }
    return <ExchangeRate>[parseHtml(htmlResponse)];
  }

  ExchangeRate parseHtml(String html) {
    final List<String> strings = <String>[];
    final RegExp exp = RegExp('грн');
    final Iterable<Match> matches = exp.allMatches(html);
    matches.forEach((Match key) {
      return strings.add(html.substring(key.start - 6, key.end - 4));
    });
    return ExchangeRate(
        Currency('USD', 'United States Dollar'),
        ExchangeBroker(
            'Minfin', const Logo('https://minfin.com.ua/favicon-32x32.png')),
        RatePublisher('https://minfin.com.ua/currency/auction/usd/buy/kharkov/',
            const Logo('https://minfin.com.ua/favicon-32x32.png')),
        id: 0,
        buy: convertToDouble(strings[0]),
        sell: convertToDouble(strings[1]),
        timestamp: DateTime.now());
  }

  double convertToDouble(String string) {
    string = string.replaceAll(',', '.');
    return double.parse(string);
  }
}
