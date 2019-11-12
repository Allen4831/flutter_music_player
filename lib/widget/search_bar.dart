import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final bool enable;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Function onSpeechPressed;
  SearchBar({
    Key key,
    this.enable = true,
    this.controller,
    this.onChanged,
    this.onSpeechPressed,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(220),
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.search, size: 22.0, color: Colors.green),
          Expanded(
            child: TextField(
                controller: widget.controller,
                onChanged: _onChanged,
                maxLines: 1,
                enabled: widget.enable,
                autofocus: widget.enable,
                textAlignVertical: TextAlignVertical.bottom,
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w300),
                //输入文本的样式
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(3.0), // 可控制文字在框中的位置
                  border: InputBorder.none,
                  hintText: '请输入歌名或歌手名',
                  hintStyle: TextStyle(fontSize: 14.0),
                )),
          ),
          InkWell(
              child: Icon(showClear ? Icons.clear : Icons.mic,
                  size: 22.0, color: Colors.green),
              onTap: () {
                if (showClear) {
                  widget.controller.clear();
                  setState(() {
                    showClear = false;
                  });
                } else {
                  // 语音识别按钮
                  widget.onSpeechPressed();
                }
              }),
        ],
      ),
    );
  }

  _onChanged(String text) {
    if (text.length > 0) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.onChanged != null) {
      widget.onChanged(text);
    }
  }
}
