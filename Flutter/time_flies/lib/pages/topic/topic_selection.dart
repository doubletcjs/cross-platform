import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:time_flies/public/public.dart';

class TopicSelection extends StatefulWidget {
  TopicSelection({Key key}) : super(key: key);

  @override
  _TopicSelectionState createState() => _TopicSelectionState();
}

class _TopicSelectionState extends State<TopicSelection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        defaultBack: true,
      ),
    );
  }
}
