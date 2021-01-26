import 'package:diary_mood/pages/mood/mood_detail.dart';
import 'package:diary_mood/pages/mood/views/mood_card.dart';
import 'package:flutter/material.dart';

class MoodListCell extends StatelessWidget {
  const MoodListCell({Key key}) : super(key: key);

  // 详情
  void _moodDetail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MoodDetailPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 12, right: 12, bottom: 12),
      elevation: 0.8,
      shadowColor: Colors.black38,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          this._moodDetail(context);
        },
        borderRadius: BorderRadius.circular(10),
        child: MoodBaseCard(),
      ),
    );
  }
}
