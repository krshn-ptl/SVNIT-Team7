import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

class BackendService {
  late List<String> options=[];
  Future<void> getdata() async {
    http.Response response =
        await http.get(Uri.parse("http://192.168.0.102:5000/symbols"));
    var tagsJson = jsonDecode(response.body.toString())['data'];
    // print(List.from(tagsJson));
    if (tagsJson == null) {
      options = [];
    } else {
      // return List.from(tagsJson);
      options = List.from(tagsJson);
    }
  }

  Future<List<String>> futureSearch(String text) async {
    // await Future.delayed(Duration(milliseconds: 10000));
    if (options.isEmpty) {
      await getdata();
    }
    // final random = Random();
    // // return null; // simulate an error
    List<String> list = <String>[];
    int j = 0;
    for (int i = 0; i < options.length; i++) {
      if (options[i].contains(text.toUpperCase())) {
        list.insert(j++, options[i]);
      }
    }

    return list;
  }
}
