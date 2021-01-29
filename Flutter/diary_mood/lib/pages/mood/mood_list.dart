import 'package:diary_mood/pages/mood/views/mood_list_cell.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MoodListPage extends StatefulWidget {
  int type = 0; // 0 最新 1 最热 2 我的 3 话题
  MoodListPage({Key key, this.type = 0}) : super(key: key);

  @override
  _MoodListPageState createState() => _MoodListPageState();
}

class _MoodListPageState extends State<MoodListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey("kMoodListPage_${this.widget.type}"),
      padding: EdgeInsets.only(top: 15),
      itemBuilder: (context, index) {
        return MoodListCell(
          showTopic: this.widget.type == 3 ? false : true,
        );
      },
      itemCount: 30,
    );
  }
}
