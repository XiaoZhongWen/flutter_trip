import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/dao/models/commom_model.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/widgets/grid_nav.dart';
import 'package:flutter_trip/pages/widgets/local_nav.dart';
import 'package:flutter_trip/dao/models/grid_nav_model.dart';
import 'package:flutter_trip/dao/models/sales_box_model.dart';
import 'package:flutter_trip/pages/widgets/sale_box.dart';
import 'package:flutter_trip/pages/widgets/sub_nav.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _appBarAlpha = 0.0;
  List<CommonModel> localNavList = [];
  List<CommonModel> subNavList = [];
  List<CommonModel> bannerList = [];
  GridNavModel gridNavModel;
  SalesBoxModel salesBox;

  // life cycle methods
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Stack(
          children: [
            MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: NotificationListener(
                  onNotification: (scrollnotification) {
                    if (scrollnotification is ScrollUpdateNotification &&
                        scrollnotification.depth == 0) {
                      _onScroll(scrollnotification.metrics.pixels);
                    }
                    return true;
                  },
                  child: ListView(
                    children: [
                      Container(
                        height: 160,
                        child: Swiper(
                          itemCount: this.bannerList.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              this.bannerList[index].icon,
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: LocalNav(
                          localNavList: this.localNavList,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: this.gridNavModel != null
                            ? GridNav(
                                gridNavModel: this.gridNavModel,
                              )
                            : null,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: this.subNavList != null
                            ? SubNav(
                                subNavList: this.subNavList,
                              )
                            : null,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                        child: this.salesBox != null
                            ? SaleBox(salesBox: this.salesBox)
                            : null,
                      ),
                    ],
                  ),
                )),
            Opacity(
              opacity: _appBarAlpha,
              child: Container(
                height: 80,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("首页"),
                  ),
                ),
              ),
            ),
            _generateSearchBanner()
          ],
        ));
  }

  _generateSearchBanner() {
    var color = this._appBarAlpha < 0.5 ? Colors.white : Colors.grey;
    var bgColor = this._appBarAlpha < 0.5 ? Colors.white : Color(0xffeeeeee);

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: EdgeInsets.only(top: 40),
      height: 30,
      child: Row(
        children: [
          Text(
            "上海",
            style: TextStyle(color: color),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: color,
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SearchPage(
                  left: Icon(Icons.arrow_back_ios),
                );
              }));
            },
            child: Container(
              height: 30,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: bgColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      Text(
                        "网红打卡",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.mic,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          )),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Icon(
              Icons.message,
              color: color,
            ),
          )
        ],
      ),
    );
  }

  // action methods
  _onScroll(offset) {
    double alpha = offset / 100;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      _appBarAlpha = alpha;
    });
  }

  // private methods
  _loadData() async {
    var homeModel = await HomeDao.fetch();
    try {
      setState(() {
        localNavList = homeModel.localNavList;
        gridNavModel = homeModel.gridNav;
        subNavList = homeModel.subNavList;
        salesBox = homeModel.salesBox;
        bannerList = homeModel.bannerList;
      });
    } catch (e) {
      print("home_page: " + e.toString());
    }
  }
}
