import 'package:flutter/material.dart';
import 'package:flutter_trip/dao/models/search_model.dart';
import 'package:flutter_trip/dao/search_dao.dart';
import 'package:flutter_trip/pages/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  final Widget left;

  const SearchPage({Key key, this.left}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String _keyword;
  Map<String, bool> assetTable = {
    "channelgroup": true,
    "channelgs": true,
    "channelplane": true,
    "channeltrain": true,
    "cruise": true,
    "district": true,
    "food": true,
    "hotel": true,
    "huodong": true,
    "shop": true,
    "sight": true,
    "ticket": true,
    "travelgroup": true,
  };

  void _onTextChange(String text) {
    _keyword = text;
    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
    } else {
      SearchDao.fetch(text).then((value) {
        if (_keyword == value.keyword) {
          setState(() {
            searchModel = value;
          });
        }
      }).catchError((onError) {
        print(onError);
      });
    }
  }

  void _onBack(BuildContext context) {
    Navigator.pop(context);
  }

  Widget _generateSubTitleWidget(SearchItem item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
          text: item.price ?? '',
          style: TextStyle(fontSize: 16, color: Colors.orange),
        ),
        TextSpan(
          text: ' ' + (item.star ?? ''),
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ]),
    );
  }

  Widget _generateTitleWidget(SearchItem item) {
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = TextStyle(fontSize: 16, color: Colors.orange);
    List<TextSpan> spans = [];
    String keyword = this.searchModel.keyword.toLowerCase();
    String word = item.word.toLowerCase();
    int preIndex = 0;
    for (int i = 0; i < word.length; i++) {
      for (int j = 0; j < keyword.length; j++) {
        if (i < word.length && word[i] == keyword[j]) {
          i++;
          if (j == keyword.length - 1) {
            if (i - keyword.length - preIndex > 0) {
              spans.add(TextSpan(
                  text: word.substring(preIndex, i - keyword.length),
                  style: normalStyle));
            }
            preIndex = i;
            spans.add(TextSpan(text: keyword, style: keywordStyle));
            break;
          }
        } else {
          break;
        }
      }
    }
    if (preIndex < word.length) {
      spans.add(TextSpan(
          text: word.substring(preIndex, word.length), style: normalStyle));
    }
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? '') + ' ' + (item.zonename ?? ''),
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(
      text: TextSpan(children: spans),
      maxLines: 2,
    );
  }

  _generateItem(BuildContext context, int index) {
    if (this.searchModel == null ||
        this.searchModel.data == null ||
        this.searchModel.data[index] == null) return null;
    SearchItem item = this.searchModel.data[index];
    return Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageNameForType(item.type),
            width: 22,
            height: 22,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Container(
                  width: 300,
                  child: _generateTitleWidget(item),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: 300,
                  child: _generateSubTitleWidget(item),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String imageNameForType(String type) {
    if (assetTable[type] == true) {
      return "images/type_$type.png";
    } else {
      return "images/type_travelgroup.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 44),
            child: SearchBar(
              left: widget.left,
              right: Text(
                "搜索",
                style: TextStyle(color: Colors.blue, fontSize: 17),
              ),
              placeholder: "搜索",
              onTextChange: this._onTextChange,
              onBack: () => this._onBack(context),
            ),
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return _generateItem(context, index);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 0.3,
                      color: Colors.grey,
                      indent: 10,
                      endIndent: 10,
                    );
                  },
                  itemCount: this.searchModel?.data?.length ?? 0)),
        ],
      ),
    );
  }
}
