import 'package:flutter/material.dart';
import 'package:time_flies/public/public.dart';

class TopicListPage extends StatefulWidget {
  TopicListPage({Key key}) : super(key: key);

  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        defaultBack: true,
      ),
    );
  }
}
