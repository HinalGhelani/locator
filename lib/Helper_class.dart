import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:locator/Modal_class.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Mnc>?> fetchData() async {

    // String baseUrl = "assets/json/mnc_detail.json";
    String api = await rootBundle.loadString("assets/json/mnc_detail.json");

    http.Response res = await http.get(Uri.parse(api));

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(api);

      List<Mnc> allList =
      decodedData.map((e) => Mnc.fromJson(json: e)).toList();

      return allList;
    }
    else {
      return null;
    }
  }
}
