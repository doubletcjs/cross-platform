import 'package:flutter/material.dart';
import 'package:mindor_flutter/public/public.dart';

class RemotePage extends StatefulWidget {
  RemotePage({Key key}) : super(key: key);

  @override
  _RemotePageState createState() => _RemotePageState();
}

class _RemotePageState extends State<RemotePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        transparentAppBar(
          brightness: Brightness.light,
        ),
        Center(
          child: Text(
            "遥控",
          ),
        ),
      ],
    );
  }
}
