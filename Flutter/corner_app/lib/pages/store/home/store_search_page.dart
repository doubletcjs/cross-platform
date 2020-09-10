import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreSearchPage extends StatefulWidget {
  StoreSearchPage({Key key}) : super(key: key);

  @override
  _StoreSearchPageState createState() => _StoreSearchPageState();
}

class _StoreSearchPageState extends State<StoreSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        defaultBack: true,
      ),
    );
  }
}
