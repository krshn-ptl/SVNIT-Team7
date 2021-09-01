import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'stockspage.dart';

import 'home_app.dart';

void main() => runApp(Stocks());

class Stocks extends StatelessWidget {
  const Stocks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late String _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        title: _text,
        onSelect: (text) => setState(() => _text = text),
      ),
      body: Front( _text),
    );
  }
}

Widget Front(String text) {
  if (text == "") {
    return Text("data");
  } else {
    return Stockpage(symbols: text);
  }
}
