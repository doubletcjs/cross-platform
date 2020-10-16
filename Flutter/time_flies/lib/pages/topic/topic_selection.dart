import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:time_flies/public/public.dart';

class TopicSelection extends StatefulWidget {
  TopicSelection({Key key}) : super(key: key);

  @override
  _TopicSelectionState createState() => _TopicSelectionState();
}

class _TopicSelectionState extends State<TopicSelection> {
  GlobalKey<ChipsInputState> _chipKey = GlobalKey();
  List _topicList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: 0.8,
                color: rgba(239, 239, 239, 1),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ChipsInput(
              key: _chipKey,
              maxChips: 15,
              autofocus: true,
              keyboardAppearance: Brightness.light,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              textStyle: TextStyle(
                height: 1.7,
                fontFamily: "Roboto",
                fontSize: 16,
              ),
              chipBuilder: (context, state, data) {
                // 所选标签
                return InputChip(
                  label: Text("$data"),
                  onDeleted: () {
                    state.deleteChip(data);
                  },
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              },
              suggestionBuilder: (context, state, data) {
                // 展示符合条件的数据
                // 点击添加标签数据 state.selectSuggestion(data),
                return ListTile(
                  title: Text("$data"),
                  onTap: () {
                    state.selectSuggestion(data);
                  },
                );
              },
              findSuggestions: (query) {
                // query 搜索条件，根据条件获取数据
                return ["a", "b", "c", "d", "e", "f", "g", "h"];
              },
              onChanged: (data) {
                kLog("$data");
                setState(() {
                  _topicList = data;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
