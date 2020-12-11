import 'dart:async';
import 'dart:convert';
import 'package:flutter_trip/dao/models/home_model.dart';
import 'package:http/http.dart' as http;

const HOME_URL = 'http://www.devio.org/io/flutter_app/json/home_page.json';

class HomeDao {
  static Future<HomeModel> fetch() async {
    var response = await http.get(HOME_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      HomeModel homeModel = HomeModel.fromJson(json.decode(utf8decoder.convert(response.bodyBytes)));
      return homeModel;
    } else {
      throw("fail to load home page data...");
    }
  }
}