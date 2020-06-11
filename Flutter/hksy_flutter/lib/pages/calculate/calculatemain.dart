import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/infosectioncell.dart';
import 'package:hksy_flutter/pages/calculate/calculatedetail.dart';
import 'package:hksy_flutter/pages/calculate/calculatehistory.dart';
import 'package:hksy_flutter/pages/calculate/views/calculatecycle.dart';
import 'package:hksy_flutter/pages/calculate/views/calculateheader.dart';
import 'package:hksy_flutter/public/public.dart';

class CalculateMain extends StatefulWidget {
  CalculateMain({Key key}) : super(key: key);

  @override
  _CalculateMainState createState() => _CalculateMainState();
}

class _CalculateMainState extends State<CalculateMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的算力",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(
            12, 0, 12, 13.5 + MediaQuery.of(context).padding.bottom),
        children: <Widget>[
          CalculateHeader(),
          CalculateCycle(),
          SizedBox(
            height: 10.5,
          ),
          InfoSection(
            cells: <Widget>[
              InfoCell(
                name: "HKC收取记录",
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return CalculateHistory();
                    }),
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 10.5,
          ),
          InfoSection(
            cells: <Widget>[
              InfoCell(
                name: "HKC兑转明细",
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return CalculateDetail();
                    }),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
