import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class GalaxyPage extends StatefulWidget {
  GalaxyPage({Key key}) : super(key: key);

  @override
  _GalaxyPageState createState() => _GalaxyPageState();
}

class _GalaxyPageState extends State<GalaxyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "Galaxy",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Center(
        child: Image.asset(
          "images/galaxy.gif",
        ),
      ),
    );
  }
}
