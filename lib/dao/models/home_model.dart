import 'package:flutter_trip/dao/models/commom_model.dart';
import 'package:flutter_trip/dao/models/config_model.dart';
import 'package:flutter_trip/dao/models/grid_nav_model.dart';
import 'package:flutter_trip/dao/models/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    var localNavListJson = json['localNavList'] as List;
    var subNavListJson = json['subNavList'] as List;
    
    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerListJson.map((item) => CommonModel.fromJson(item)).toList(),
      localNavList: localNavListJson.map((item) => CommonModel.fromJson(item)).toList(),
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList: subNavListJson.map((item) => CommonModel.fromJson(item)).toList(),
      salesBox: SalesBoxModel.fromJson(json['salesBox'])
    );
  }
}
