import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

class StoreDetailApply extends StatefulWidget {
  StoreDetailApply({Key key}) : super(key: key);

  @override
  _StoreDetailApplyState createState() => _StoreDetailApplyState();
}

class _StoreDetailApplyState extends State<StoreDetailApply> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "新的申请",
        defaultBack: true,
      ),
    );
  }
}
