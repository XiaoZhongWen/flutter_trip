import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606994210751&di=b6eee19d62a96c2089d6051274b29bf2&imgtype=0&src=http%3A%2F%2Fimg.article.pchome.net%2F00%2F34%2F09%2F06%2Fpic_lib%2Fs960x639%2Fjmfj061s960x639.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1606994236993&di=2ed525e1735707783916f63a294be9c3&imgtype=0&src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F7%2F584260a8b8615.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=299377739,3652585808&fm=11&gp=0.jpg"
  ];

  double _appBarAlpha = 0.0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Container(
                        height: 800,
                        child: ListTile(
                          title: Text("Julien"),
                        ),
                      )
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
            )
          ],
        )
    );
  }
}
