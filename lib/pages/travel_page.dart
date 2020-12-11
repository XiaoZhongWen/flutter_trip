import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/widgets/travel_tab_page.dart';

// import 'package:unde';
import 'package:flutter_trip/pages/widgets/travel_top_tab.dart';
import 'package:flutter_trip/dao/models/travel_tab_model.dart';
import 'package:flutter_trip/dao/travel_tab_dao.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  TravelTabModel travelTabModel;
  TabController _controller;
  List<TravelTab> _tabs = [];

  @override
  void initState() {
    _controller = TabController(length: 0, vsync: this);
    _loaddata();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: TabBar(
                controller: _controller,
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Color(0xff2fcfbb), width: 3),
                    insets: EdgeInsets.only(bottom: 10)),
                tabs: _tabs.map((TravelTab tab) {
                  return Tab(
                    text: tab.labelName,
                  );
                }).toList()),
          ),
          Flexible(
              child: TabBarView(
            controller: _controller,
            children: _tabs
                .map((tab) => TravelTabPage(
                      travelUrl: travelTabModel.url,
                      params: travelTabModel.params,
                      groupChannelCode: tab.groupChannelCode,
                    ))
                .toList(),
          ))
        ],
      ),
    );
  }

  _loaddata() async {
    try {
      var result = await TravelTabDao.fetch();
      _controller = TabController(length: result.tabs.length, vsync: this);
      setState(() {
        travelTabModel = result;
        _tabs = result.tabs;
      });
    } catch (e) {}
  }
}
