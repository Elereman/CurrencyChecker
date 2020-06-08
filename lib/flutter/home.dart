import 'package:DollarCheck/bloc/live/bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  static const String _title = 'DollarCheck';

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_title),
      ),
      body: ListView(
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.update),
        onPressed: () => update(),
      ),
    );
  }

//  void showToast(String text) {
//    Fluttertoast.showToast(
//        msg: text,
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.BOTTOM,
//        timeInSecForIosWeb: 1,
//        backgroundColor: Colors.grey,
//        textColor: Colors.white,
//        fontSize: 16.0);
//  }

// List<Widget> buildList() {
//    return data
//        .map((ExchangeRate d) => ListTile(
//              title: Text(d.timestamp.year.toString() +
//                  '.' +
//                  d.timestamp.month.toString() +
//                  '.' +
//                  d.timestamp.day.toString()),
//              subtitle: Text(d.timestamp.hour.toString() +
//                  ':' +
//                  d.timestamp.minute.toString() +
//                  ':' +
//                  d.timestamp.second.toString()),
//              leading: CircleAvatar(
//                  child: Text(
//                      (d.id == 0
//                                  ? d.id
//                                  : data[d.id].sell < data[d.id - 1].sell
//                                      ? String.fromCharCode(0x2191)
//                                      : String.fromCharCode(0x2193))
//                              .toString() +
//                          (d.id == 0
//                                  ? d.id
//                                  : data[d.id].buy < data[d.id - 1].buy
//                                      ? String.fromCharCode(0x2191)
//                                      : String.fromCharCode(0x2193))
//                              .toString(),
//                      style: TextStyle(fontWeight: FontWeight.w900))),
//              trailing: Column(
//                children: <Widget>[
//                  Text('Покупка: ' + d.buy.toString()),
//                  Text(''),
//                  Text('Продажа: ' + d.sell.toString())
//                ],
//              ),
//            ))
//        .toList();
//  }
}
