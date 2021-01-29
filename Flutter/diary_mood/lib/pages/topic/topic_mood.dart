import 'package:diary_mood/pages/mood/mood_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TopicMood extends StatefulWidget {
  Map topic;
  TopicMood({
    Key key,
    this.topic,
  }) : super(key: key);

  @override
  _TopicMoodState createState() => _TopicMoodState();
}

class _TopicMoodState extends State<TopicMood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "#topictopictopictopictopic#",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: MoodListPage(
        type: 3,
      ),
    );
  }
}
