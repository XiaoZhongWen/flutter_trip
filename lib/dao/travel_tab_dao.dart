import 'dart:convert';
import 'package:flutter_trip/dao/models/travel_tab_model.dart';
import 'package:http/http.dart' as http;

const TRAVEL_TAB_URL =
    "http://www.devio.org/io/flutter_app/json/travel_page.json";

class TravelTabDao {
  static Future<TravelTabModel> fetch() async {
    var response = await http.get(TRAVEL_TAB_URL);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      TravelTabModel travelTabModel = TravelTabModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
      return travelTabModel;
    } else {
      throw ("fetch travel tab failure!");
    }
  }
}
