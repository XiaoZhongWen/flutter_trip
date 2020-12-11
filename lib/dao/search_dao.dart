import 'dart:convert';
import 'package:flutter_trip/dao/models/search_model.dart';
import 'package:http/http.dart' as http;

const SEARCH_URL =
    "https://m.ctrip.com/restapi/h5api/globalsearch/search?source=mobileweb&action=mobileweb&keyword=";

class SearchDao {
  static Future<SearchModel> fetch(String keyword) async {
    String url = SEARCH_URL + keyword;
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      SearchModel searchModel = SearchModel.fromJson(
          json.decode(utf8decoder.convert(response.bodyBytes)));
      searchModel.keyword = keyword;
      return searchModel;
    } else {
      throw ("fail to load search data...");
    }
  }
}
