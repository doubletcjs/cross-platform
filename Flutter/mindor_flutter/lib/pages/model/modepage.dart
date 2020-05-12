import 'package:flutter/material.dart';
import 'package:mindor_flutter/public/public.dart';

class ModelPage extends StatefulWidget {
  ModelPage({Key key}) : super(key: key);

  @override
  _ModelPageState createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        transparentAppBar(
          brightness: Brightness.light,
        ),
        Center(
          child: Text(
            "模式",
          ),
        ),
      ],
    );
  }
}
