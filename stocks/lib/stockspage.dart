import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
String ip = "192.168.0.102";

class Stockpage extends StatefulWidget {
  final String symbols;
  Stockpage({required this.symbols});
  @override
  _StockpageState createState() => _StockpageState();
}

class _StockpageState extends State<Stockpage> {
  List<String> item = <String>[
    'OHLC Chart',
    'CandleSticks Chart',
    'Hilo Chart',
    'Bar Chart',
  ];
  List<String> time = <String>[
    '1 W',
    '1 M',
    '6 M',
  ];

  String selectedUser = 'OHLC Chart';
  String selectedTime = "1 W";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  hint: Text("Select item"),
                  value: selectedUser,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedUser = newValue!;
                    });
                  },
                  items: item.map((String user) {
                    return DropdownMenuItem<String>(
                      value: user,
                      child: Text(user),
                    );
                  }).toList(),
                ),
                SizedBox(
                  width: 30,
                ),
                DropdownButton<String>(
                  hint: Text("Select item"),
                  value: selectedTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTime = newValue!;
                    });
                  },
                  items: time.map((String user) {
                    return DropdownMenuItem<String>(
                      value: user,
                      child: Text(user),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            child: FutureBuilder(
              future: function(widget.symbols, selectedTime),
              builder: (BuildContext context,
                  AsyncSnapshot<List<ChartSampleData>> snapshot) {
                return chartplot(snapshot.data, selectedUser);
              },
            ),
          ),
          // Container(
          //   child: Column(
          //     children: [
          //       FutureBuilder(
          //         builder:
          //             (BuildContext context, AsyncSnapshot<String> snapshot) {
          //           return Text(snapshot.data!);
          //         },
          //         future: getinfo(widget.symbols),
          //       )
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}

class ChartSampleData {
  ChartSampleData({this.date, this.open, this.close, this.high, this.low});
  final DateTime? date;
  final num? open;
  final num? close;
  final num? low;
  final num? high;

  factory ChartSampleData.fromJson(Map<String, dynamic> json) {
    return ChartSampleData(
      date: DateTime.parse(json["date"]),
      open: json["open"],
      close: json["close"],
      low: json["low"],
      high: json["high"],
    );
  }
}

Future<List<ChartSampleData>> function(String type, String time) async {
  int timerange = 0;
  if (time == '1 W') {
    timerange = 1;
  } else if (time == '1 M') {
    timerange = 2;
  } else if (time == '6 M') {
    timerange = 3;
  } else if (time == 'All') {
    timerange = 4;
  }
  List<ChartSampleData> _value = await getChartData(type, timerange);
  return _value;
}

Widget chartplot(List<ChartSampleData>? _value, String type) {
  if (type == "CandleSticks Chart") {
    // List<ChartSampleData> _value = await getChartData(type, timerange);
    var _trackball = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    return SfCartesianChart(
      trackballBehavior: _trackball,
      title: ChartTitle(text: type),
      series: <CandleSeries>[
        CandleSeries<ChartSampleData, DateTime>(
            dataSource: _value!,
            name: type,
            xValueMapper: (ChartSampleData sales, _) => sales.date,
            lowValueMapper: (ChartSampleData sales, _) => sales.low,
            highValueMapper: (ChartSampleData sales, _) => sales.high,
            openValueMapper: (ChartSampleData sales, _) => sales.open,
            closeValueMapper: (ChartSampleData sales, _) => sales.close)
      ],
      primaryXAxis: DateTimeAxis(),
    );
  } else if (type == "OHLC Chart") {
    // List<ChartSampleData> _value = await getChartData(type, timerange);
    var _trackball = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    return SfCartesianChart(
      trackballBehavior: _trackball,
      title: ChartTitle(text: type),
      series: <HiloOpenCloseSeries>[
        HiloOpenCloseSeries<ChartSampleData, DateTime>(
            dataSource: _value!,
            name: type,
            xValueMapper: (ChartSampleData sales, _) => sales.date,
            lowValueMapper: (ChartSampleData sales, _) => sales.low,
            highValueMapper: (ChartSampleData sales, _) => sales.high,
            openValueMapper: (ChartSampleData sales, _) => sales.open,
            closeValueMapper: (ChartSampleData sales, _) => sales.close)
      ],
      primaryXAxis: DateTimeAxis(),
    );
  } else if (type == "Hilo Chart") {
    // List<ChartSampleData> _value = await getChartData(type, timerange);
    var _trackball = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    return SfCartesianChart(
      trackballBehavior: _trackball,
      title: ChartTitle(text: type),
      series: <HiloSeries>[
        HiloSeries<ChartSampleData, DateTime>(
          dataSource: _value!,
          name: type,
          xValueMapper: (ChartSampleData sales, _) => sales.date,
          lowValueMapper: (ChartSampleData sales, _) => sales.low,
          highValueMapper: (ChartSampleData sales, _) => sales.high,
        )
      ],
      primaryXAxis: DateTimeAxis(),
    );
  } else if (type == "Bar Chart") {
    // List<ChartSampleData> _value = await getChartData(type, timerange);
    var _trackball = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    return SfCartesianChart(
      trackballBehavior: _trackball,
      title: ChartTitle(text: type),
      series: <RangeColumnSeries>[
        RangeColumnSeries<ChartSampleData, DateTime>(
          dataSource: _value!,
          name: type,
          xValueMapper: (ChartSampleData sales, _) => sales.date,
          lowValueMapper: (ChartSampleData sales, _) => sales.low,
          highValueMapper: (ChartSampleData sales, _) => sales.high,
        )
      ],
      primaryXAxis: DateTimeAxis(),
    );
  } else {
    return Text("Hi");
  }
}

Future<List<ChartSampleData>> getjson(
    String type, DateTime start, DateTime end) async {
  String sm = start.month.toString();
  String sd = start.day.toString();
  String em = end.month.toString();
  String ed = end.day.toString();
  if (sm.length < 2) {
    sm = "0" + sm;
  }
  if (sd.length < 2) {
    sd = "0" + sd;
  }
  if (em.length < 2) {
    em = "0" + em;
  }
  if (ed.length < 2) {
    ed = "0" + ed;
  }
  Uri usi = Uri.parse("http://$ip:5000/getdata?symbol=" +
      type +
      "&inidate=${start.year}-" +
      sm +
      "-" +
      sd +
      "&fidate=${end.year}-" +
      em +
      "-" +
      ed +
      "");
  http.Response response = await http.get(usi);
  List<dynamic> responselen = jsonDecode(response.body)['data'];
  List<ChartSampleData> val = responselen
      .map((responselen) => ChartSampleData.fromJson(responselen))
      .toList();

  return val;
}

Future<String> getinfo(String symbol) async {
  Uri usi = Uri.parse(
      "https://cloud.iexapis.com/stable/tops?token=pk_5c893154fa724e5c86da662f0811e5ee&symbols=" +
          symbol);
  http.Response response = await http.get(usi);
  print(response.body.toString());
  // Map<String, dynamic> map = jsonDecode(response.body.toString());

  String val = '';
  // responselen
  //     .map((responselen) => ChartSampleData.fromJson(responselen))
  //     .toList();

  return val;
}

Future<List<ChartSampleData>> getjson2(String type) async {
  http.Response response =
      await http.get(Uri.parse("http://$ip:5000/getdata?symbol=" + type));

  List<dynamic> responselen = jsonDecode(response.body)['data'];
  List<ChartSampleData> val = responselen
      .map((responselen) => ChartSampleData.fromJson(responselen))
      .toList();

  return val;
}

Future<List<ChartSampleData>> getChartData(String type, int timerange) {
  DateTime alpha = new DateTime(2021, 08, 01);
  DateTime start = alpha;
  DateTime end = alpha;
  if (timerange == 1) {
    start = start.subtract(new Duration(days: 7));
  } else if (timerange == 2) {
    start = start.subtract(new Duration(days: 30));
  } else if (timerange == 3) {
    start = start.subtract(new Duration(days: 180));
  }

  Future<List<ChartSampleData>> data = getjson(type, start, end);
  if (timerange == 4) {
    data = getjson2(type);
  }
  return data;
}
//   return <ChartSampleData>[
//     ChartSampleData(
//         date: DateTime(2016, 01, 11),
//         open: 98.97,
//         high: 101.19,
//         low: 95.36,
//         close: 97.13),
//     ChartSampleData(
//         date: DateTime(2016, 01, 18),
//         open: 98.41,
//         high: 101.46,
//         low: 93.42,
//         close: 101.42),
//     ChartSampleData(
//         date: DateTime(2016, 01, 25),
//         open: 101.52,
//         high: 101.53,
//         low: 92.39,
//         close: 97.34),
//     ChartSampleData(
//         date: DateTime(2016, 02, 01),
//         open: 96.47,
//         high: 97.33,
//         low: 93.69,
//         close: 94.02),
//     ChartSampleData(
//         date: DateTime(2016, 02, 08),
//         open: 93.13,
//         high: 96.35,
//         low: 92.59,
//         close: 93.99),
//     ChartSampleData(
//         date: DateTime(2016, 02, 15),
//         open: 91.02,
//         high: 94.89,
//         low: 90.61,
//         close: 92.04),
//     ChartSampleData(
//         date: DateTime(2016, 02, 22),
//         open: 96.31,
//         high: 98.0237,
//         low: 98.0237,
//         close: 96.31),
//     ChartSampleData(
//         date: DateTime(2016, 02, 29),
//         open: 99.86,
//         high: 106.75,
//         low: 99.65,
//         close: 106.01),
//     ChartSampleData(
//         date: DateTime(2016, 03, 07),
//         open: 102.39,
//         high: 102.83,
//         low: 100.15,
//         close: 102.26),
//     ChartSampleData(
//         date: DateTime(2016, 03, 14),
//         open: 101.91,
//         high: 106.5,
//         low: 101.78,
//         close: 105.92),
//     ChartSampleData(
//         date: DateTime(2016, 03, 21),
//         open: 105.93,
//         high: 107.65,
//         low: 104.89,
//         close: 105.67),
//     ChartSampleData(
//         date: DateTime(2016, 03, 28),
//         open: 106,
//         high: 110.42,
//         low: 104.88,
//         close: 109.99),
//     ChartSampleData(
//         date: DateTime(2016, 04, 04),
//         open: 110.42,
//         high: 112.19,
//         low: 108.121,
//         close: 108.66),
//     ChartSampleData(
//         date: DateTime(2016, 04, 11),
//         open: 108.97,
//         high: 112.39,
//         low: 108.66,
//         close: 109.85),
//     ChartSampleData(
//         date: DateTime(2016, 04, 18),
//         open: 108.89,
//         high: 108.95,
//         low: 104.62,
//         close: 105.68),
//     ChartSampleData(
//         date: DateTime(2016, 04, 25),
//         open: 105,
//         high: 105.65,
//         low: 92.51,
//         close: 93.74),
//     ChartSampleData(
//         date: DateTime(2016, 05, 02),
//         open: 93.965,
//         high: 95.9,
//         low: 91.85,
//         close: 92.72),
//     ChartSampleData(
//         date: DateTime(2016, 05, 09),
//         open: 93,
//         high: 93.77,
//         low: 89.47,
//         close: 90.52),
//     ChartSampleData(
//         date: DateTime(2016, 05, 16),
//         open: 92.39,
//         high: 95.43,
//         low: 91.65,
//         close: 95.22),
//     ChartSampleData(
//         date: DateTime(2016, 05, 23),
//         open: 95.87,
//         high: 100.73,
//         low: 95.67,
//         close: 100.35),
//     ChartSampleData(
//         date: DateTime(2016, 05, 30),
//         open: 99.6,
//         high: 100.4,
//         low: 96.63,
//         close: 97.92),
//     ChartSampleData(
//         date: DateTime(2016, 06, 06),
//         open: 97.99,
//         high: 101.89,
//         low: 97.55,
//         close: 98.83),
//     ChartSampleData(
//         date: DateTime(2016, 06, 13),
//         open: 98.69,
//         high: 99.12,
//         low: 95.3,
//         close: 95.33),
//     ChartSampleData(
//         date: DateTime(2016, 06, 20),
//         open: 96,
//         high: 96.89,
//         low: 92.65,
//         close: 93.4),
//     ChartSampleData(
//         date: DateTime(2016, 06, 27),
//         open: 93,
//         high: 96.465,
//         low: 91.5,
//         close: 95.89),
//     ChartSampleData(
//         date: DateTime(2016, 07, 04),
//         open: 95.39,
//         high: 96.89,
//         low: 94.37,
//         close: 96.68),
//     ChartSampleData(
//         date: DateTime(2016, 07, 11),
//         open: 96.75,
//         high: 99.3,
//         low: 96.73,
//         close: 98.78),
//     ChartSampleData(
//         date: DateTime(2016, 07, 18),
//         open: 98.7,
//         high: 101,
//         low: 98.31,
//         close: 98.66),
//     ChartSampleData(
//         date: DateTime(2016, 07, 25),
//         open: 98.25,
//         high: 104.55,
//         low: 96.42,
//         close: 104.21),
//     ChartSampleData(
//         date: DateTime(2016, 08, 01),
//         open: 104.41,
//         high: 107.65,
//         low: 104,
//         close: 107.48),
//     ChartSampleData(
//         date: DateTime(2016, 08, 08),
//         open: 107.52,
//         high: 108.94,
//         low: 107.16,
//         close: 108.18),
//     ChartSampleData(
//         date: DateTime(2016, 08, 15),
//         open: 108.14,
//         high: 110.23,
//         low: 108.08,
//         close: 109.36),
//     ChartSampleData(
//         date: DateTime(2016, 08, 22),
//         open: 108.86,
//         high: 109.32,
//         low: 106.31,
//         close: 106.94),
//     ChartSampleData(
//         date: DateTime(2016, 08, 29),
//         open: 106.62,
//         high: 108,
//         low: 105.5,
//         close: 107.73),
//     ChartSampleData(
//         date: DateTime(2016, 09, 05),
//         open: 107.9,
//         high: 108.76,
//         low: 103.13,
//         close: 103.13),
//     ChartSampleData(
//         date: DateTime(2016, 09, 12),
//         open: 102.65,
//         high: 116.13,
//         low: 102.53,
//         close: 114.92),
//     ChartSampleData(
//         date: DateTime(2016, 09, 19),
//         open: 115.19,
//         high: 116.18,
//         low: 111.55,
//         close: 112.71),
//     ChartSampleData(
//         date: DateTime(2016, 09, 26),
//         open: 111.64,
//         high: 114.64,
//         low: 111.55,
//         close: 113.05),
//     ChartSampleData(
//         date: DateTime(2016, 10, 03),
//         open: 112.71,
//         high: 114.56,
//         low: 112.28,
//         close: 114.06),
//     ChartSampleData(
//         date: DateTime(2016, 10, 10),
//         open: 115.02,
//         high: 118.69,
//         low: 114.72,
//         close: 117.63),
//     ChartSampleData(
//         date: DateTime(2016, 10, 17),
//         open: 117.33,
//         high: 118.21,
//         low: 113.8,
//         close: 116.6),
//     ChartSampleData(
//         date: DateTime(2016, 10, 24),
//         open: 117.1,
//         high: 118.36,
//         low: 113.31,
//         close: 113.72),
//     ChartSampleData(
//         date: DateTime(2016, 10, 31),
//         open: 113.65,
//         high: 114.23,
//         low: 108.11,
//         close: 108.84),
//     ChartSampleData(
//         date: DateTime(2016, 11, 07),
//         open: 110.08,
//         high: 111.72,
//         low: 105.83,
//         close: 108.43),
//     ChartSampleData(
//         date: DateTime(2016, 11, 14),
//         open: 107.71,
//         high: 110.54,
//         low: 104.08,
//         close: 110.06),
//     ChartSampleData(
//         date: DateTime(2016, 11, 21),
//         open: 114.12,
//         high: 115.42,
//         low: 115.42,
//         close: 114.12),
//     ChartSampleData(
//         date: DateTime(2016, 11, 28),
//         open: 111.43,
//         high: 112.465,
//         low: 108.85,
//         close: 109.9),
//     ChartSampleData(
//         date: DateTime(2016, 12, 05),
//         open: 110,
//         high: 114.7,
//         low: 108.25,
//         close: 113.95),
//     ChartSampleData(
//         date: DateTime(2016, 12, 12),
//         open: 113.29,
//         high: 116.73,
//         low: 112.49,
//         close: 115.97),
//     ChartSampleData(
//         date: DateTime(2016, 12, 19),
//         open: 115.8,
//         high: 117.5,
//         low: 115.59,
//         close: 116.52),
//     ChartSampleData(
//         date: DateTime(2016, 12, 26),
//         open: 116.52,
//         high: 118.0166,
//         low: 115.43,
//         close: 115.82),
//   ];
// }
