import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:DollarCheck/dollarDB.dart';
import 'package:DollarCheck/domain/dollar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'domain/dollar.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  List<Dollar> data = <Dollar>[];
  Timer _timer;
  DollarDB _dollarDB;
  final String _title = 'DollarCheck';

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dollarDB = DollarDB();
    //data.addAll(await loadList());
    loadList().then((dollars) => print(dollars));
    startTimer();
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: ListView(
          children: buildList(),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.update),
        onPressed: () => update(),
      ),
    );
  }

  void startTimer() {
    final Duration time = Duration(minutes: 15);
    if (_timer == null) {
      update();
      _timer = Timer.periodic(time, (Timer timer) => update());
    }
  }

  void update() async {
    showToast('Обновление');
    String response = '';
    const String url = 'https://minfin.com.ua/currency/auction/usd/buy/kharkov/';
    final HttpClient client = HttpClient();
    final HttpClientRequest request = await client.getUrl(Uri.parse(url));
    final HttpClientResponse requestResponse = await request.close();
    await for (String contents in requestResponse.transform(Utf8Decoder())) {
      response = response + contents;
    }
    buildList();
    setState(() {
      addToList(parseHtml(response));
    });
    saveList(data);
  }

  void showToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<List<Dollar>> loadList() async {
    _dollarDB.createDB();
    return await _dollarDB.dollars();
  }

  void saveList(List<Dollar> dollars) {
    _dollarDB.createDB();
    _dollarDB.insertDollars(dollars);
  }

  void addToList(Dollar dollar) {
    Dollar added;
    if (data.isNotEmpty) {
      data.forEach((d) {
        if (dollar.buy != d.buy) {
          added = d;
        } else if (dollar.sell != d.sell) {
          added = d;
        }
      });
    } else {
      data.add(dollar);
    }

    if (added != null) {
      data.add(added);
    }
  }

  Dollar parseHtml(String html) {
    Dollar result;
    final List<String> strings = <String>[];
    final RegExp exp = RegExp('грн');
    final Iterable<Match> matches = exp.allMatches(html);
    matches.forEach(
        (Match key) => strings.add(html.substring(key.start - 6, key.end - 4)));
    result = Dollar(
        id: data.length,
        buy: convertToDouble(strings[0]),
        sell: convertToDouble(strings[1]),
        date: DateTime.now());
    return result;
  }

  double convertToDouble(String string) {
    string = string.replaceAll(',', '.');
    return double.parse(string);
  }

  List<Widget> buildList() {
    return data
        .map((Dollar d) => ListTile(
              title: Text(d.date.year.toString() +
                  '.' +
                  d.date.month.toString() +
                  '.' +
                  d.date.day.toString()),
              subtitle: Text(d.date.hour.toString() +
                  ':' +
                  d.date.minute.toString() +
                  ':' +
                  d.date.second.toString()),
              leading: CircleAvatar(
                  child: Text(
                      (d.id == 0
                                  ? d.id
                                  : data[d.id].sell < data[d.id - 1].sell
                                      ? String.fromCharCode(0x2191)
                                      : String.fromCharCode(0x2193))
                              .toString() +
                          (d.id == 0
                                  ? d.id
                                  : data[d.id].buy < data[d.id - 1].buy
                                      ? String.fromCharCode(0x2191)
                                      : String.fromCharCode(0x2193))
                              .toString(),
                      style: TextStyle(fontWeight: FontWeight.w900))),
              trailing: Column(
                children: <Widget>[
                  Text('Покупка: ' + d.buy.toString()),
                  Text(''),
                  Text('Продажа: ' + d.sell.toString())
                ],
              ),
            ))
        .toList();
  }
}
