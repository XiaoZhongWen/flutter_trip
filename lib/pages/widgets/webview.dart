import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {

  String url;
  final String title;
  final String statusBarColor;
  final bool hideAppBar;
  final bool backForbid;

  WebView({this.url, this.title, this.statusBarColor, this.hideAppBar, this.backForbid = false}) {
    if (url != null && url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      url = url.replaceAll("http://", 'https://');
    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class _WebViewState extends State<WebView> {
  final _webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;
  bool exiting = false;

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void initState() {
    super.initState();
    _onUrlChanged = _webviewReference.onUrlChanged.listen((String url) { });
    _onStateChanged = _webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch(state.type) {
        case WebViewState.startLoad: {
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              _webviewReference.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
        }
      }
    });
    _onHttpError = _webviewReference.onHttpError.listen((WebViewHttpError error) { });
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    _webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.statusBarColor??'ffffff';
    var backButtonColor = Colors.white;
    if (statusBarColor == 'ffffff') {
      backButtonColor = Colors.black;
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(context, Color(int.parse('0xff' + statusBarColor)), backButtonColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              userAgent: null,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waiting...'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _appBar(BuildContext context, Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar) {
      return Container(
        height: 30,
        color: backgroundColor,
      );
    } else {
      return Container(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
        color: backgroundColor,
        child: FractionallySizedBox(
            widthFactor: 1,
          child: Stack(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                ),
              ),
              Positioned(
                child: Center(
                  child: Text(widget.title, style: TextStyle(color: backButtonColor, fontSize: 20),),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
