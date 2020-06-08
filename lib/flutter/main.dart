import 'package:DollarCheck/flutter/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(DollarCheck());

class DollarCheck extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DollarCheck',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: HomePage(),
    );
  }

}
