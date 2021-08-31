import 'package:flutter/material.dart';

class Stockpage extends StatefulWidget {
  Stockpage({Key? key}) : super(key: key);

  @override
  _StockpageState createState() => _StockpageState();
}

class _StockpageState extends State<Stockpage> {
  List<String> item = <String>[
    'OHLC Chart',
    'CandleSticks Chart',
    'Colored Bar',
    'Vertex Linw',
    'Hollow Candle'
  ];

  String selectedUser = 'OHLC Chart';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: DropdownButton<String>(
              hint: Text("Select item"),
              value: selectedUser,
              onChanged: (String newValue) {
                setState(() {
                  selectedUser = newValue;
                });
              },
              items: item.map((String user) {
                return DropdownMenuItem<String>(
                  value: user,
                  child: Text(user),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
