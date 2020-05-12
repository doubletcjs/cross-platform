import 'package:flutter/material.dart';
import 'package:mindor_flutter/public/public.dart';

class MallPage extends StatefulWidget {
  MallPage({Key key}) : super(key: key);

  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        transparentAppBar(
          brightness: Brightness.light,
        ),
        Center(
          child: Text(
            "商城",
          ),
        ),
      ],
    );
  }
}
