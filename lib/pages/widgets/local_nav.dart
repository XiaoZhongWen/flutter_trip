import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/models/commom_model.dart';
import 'package:flutter_trip/pages/widgets/webview.dart';

class LocalNav extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNav({Key key, this.localNavList}) : super(key: key);

  _tabs(BuildContext context) {
    if (this.localNavList.length == 0) {
      return null;
    } else {
      List<Widget> items = [];
      this.localNavList.forEach((element) {
        var item = GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return WebView(
                url: element.url,
                title: element.title,
                statusBarColor: element.statusBarColor,
                hideAppBar: element.hideAppBar,
              );
            }));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                element.icon,
                width: 32,
                height: 32,
              ),
              Text(
                element.title,
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        );
        items.add(item);
      });

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: _tabs(context),
      ),
    );
  }
}
