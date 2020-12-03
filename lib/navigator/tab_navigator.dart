import 'package:flutter/material.dart';
import 'package:flutter_trip/pages/home_page.dart';
import 'package:flutter_trip/pages/my_page.dart';
import 'package:flutter_trip/pages/search_page.dart';
import 'package:flutter_trip/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);

  Color _defaultColor = Colors.grey;
  Color _activeColor = Colors.blue;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [HomePage(), TravelPage(), SearchPage(), MyPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? _activeColor : _defaultColor,
            ),
            // activeIcon: Icon(Icons.home, color: _activeColor),
            title: Text(
              "首页",
              style: TextStyle(
                  color: _currentIndex == 0 ? _activeColor : _defaultColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt,
                color: _currentIndex == 1 ? _activeColor : _defaultColor),
            // activeIcon: Icon(Icons.camera_alt, color: _activeColor),
            title: Text(
              "旅拍",
              style: TextStyle(
                  color: _currentIndex == 1 ? _activeColor : _defaultColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _currentIndex == 2 ? _activeColor : _defaultColor),
            // activeIcon: Icon(Icons.search, color: _activeColor),
            title: Text(
              "搜索",
              style: TextStyle(
                  color: _currentIndex == 2 ? _activeColor : _defaultColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle,
                color: _currentIndex == 3 ? _activeColor : _defaultColor),
            // activeIcon: Icon(Icons.account_circle, color: _activeColor),
            title: Text(
              "我的",
              style: TextStyle(
                  color: _currentIndex == 3 ? _activeColor : _defaultColor),
            ),
          )
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
