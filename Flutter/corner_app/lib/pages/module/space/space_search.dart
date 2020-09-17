import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class SpaceSearchPage extends StatefulWidget {
  SpaceSearchPage({Key key}) : super(key: key);

  @override
  _SpaceSearchPageState createState() => _SpaceSearchPageState();
}

class _SpaceSearchPageState extends State<SpaceSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        defaultBack: true,
      ),
    );
  }
}
