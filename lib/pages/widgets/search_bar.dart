import 'package:flutter/material.dart';

// typedef ValueChanged = void Function(String);

class SearchBar extends StatefulWidget {
  final Widget left;
  final Widget right;
  final String placeholder;
  final ValueChanged<String> onTextChange;
  final VoidCallback onBack;

  const SearchBar(
      {Key key,
      this.left,
      this.right,
      this.placeholder,
      this.onTextChange,
      this.onBack})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  String _keyWord = "";

  _generateWidgets(BuildContext context) {
    List<Widget> widgets = [];
    if (widget.left != null) {
      widgets.add(GestureDetector(
        onTap: () {
          widget.onBack();
        },
        child: widget.left,
      ));
    }

    Widget inputBox = Expanded(
      child: Container(
        height: 30,
        margin: EdgeInsets.only(right: 5),
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(int.parse('0xffEDEDED'))),
        child: Row(
          children: [
            Icon(
              Icons.search,
              color: Color(0xffA9A9A9),
            ),
            Expanded(
              child: TextField(
                autofocus: true,
                style: TextStyle(fontSize: 18),
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: widget.placeholder ?? "",
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 10)),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (this._keyWord.length > 0) {
                  _textEditingController.clear();
                  widget.onTextChange('');
                }
              },
              child: Icon(
                _keyWord.length == 0 ? Icons.mic : Icons.close,
                color: _keyWord.length == 0 ? Colors.blue : Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
    widgets.add(inputBox);
    if (widget.right != null) {
      widgets.add(widget.right);
    }
    return widgets;
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      setState(() {
        _keyWord = _textEditingController.text;
        widget.onTextChange(_keyWord);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: _generateWidgets(context),
      ),
    );
  }
}
