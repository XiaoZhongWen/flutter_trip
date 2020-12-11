import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/models/grid_nav_model.dart';
import 'package:flutter_trip/dao/models/commom_model.dart';
import 'package:flutter_trip/pages/widgets/webview.dart';

class GridNav extends StatelessWidget {

  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  _generateItem(BuildContext context, CommonModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(url: item.url, title: item.title, statusBarColor: item.statusBarColor, hideAppBar: item.hideAppBar??false,);
        }));
      },
      child: Container(
        child: Text(item.title, style: TextStyle(color: Colors.white),),
      ),
    );
  }

  _generateMainGridItem(BuildContext context, CommonModel item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(url: item.url, title: item.title, statusBarColor: item.statusBarColor, hideAppBar: item.hideAppBar??false,);
        }));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(item.icon, width: 121, height: 88, alignment: AlignmentDirectional.bottomEnd, fit: BoxFit.contain,),
          Positioned(
            top: 10,
            child: Text(item.title, style: TextStyle(color: Colors.white),),)
        ],
      ),
    );
  }

  _generateGridItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Container(
      height: 100.0,
      decoration: BoxDecoration(border: Border(left: BorderSide(width: 0.5, color: Colors.white))),
      child: Column(
        children: [
          Expanded(child: Container(alignment: Alignment.center, child: _generateItem(context, topItem),)),
          Divider(height: 0.5, color: Colors.white,),
          Expanded(child: Container(alignment: Alignment.center, child: _generateItem(context, bottomItem),)),
        ],
      ),
    );
  }

  _generateGridNavRow(BuildContext context, GridNavItem item) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(int.parse('0xff' + item.startColor)), Color(int.parse('0xff' + item.endColor))]),
      ),
      child: Row(
        children: [
          _generateMainGridItem(context, item.mainItem),
          Expanded(child: _generateGridItem(context, item.item1, item.item2)),
          Expanded(child: _generateGridItem(context, item.item3, item.item4)),
        ],
      ),
    );
  }

  _generateNavCard(BuildContext context) {
    List<GridNavItem> items = [];
    if (gridNavModel.hotel != null) {
      items.add(gridNavModel.hotel);
    }
    if (gridNavModel.flight != null) {
      items.add(gridNavModel.flight);
    }
    if (gridNavModel.travel != null) {
      items.add(gridNavModel.travel);
    }
    List<Widget> list = [];
    for (int i = 0; i < items.length; i++) {
      if (i != 0) {
        list.add(Divider(height: 1, color: Colors.white,));
      }
      list.add(_generateGridNavRow(context, items[i]));
      if (i != items.length - 1) {
        list.add(Divider(height: 1, color: Colors.white,));
      }
    }
    if (list.length > 0) {
      return list;
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        child: Column(
            children: _generateNavCard(context)
        ),
      ),
    );
  }
}
