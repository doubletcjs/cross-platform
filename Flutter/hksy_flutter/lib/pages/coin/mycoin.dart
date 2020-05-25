import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/coin/views/coinheader.dart';
import 'package:hksy_flutter/pages/coin/views/coinsectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class MyCoinPage extends StatefulWidget {
  MyCoinPage({Key key}) : super(key: key);

  @override
  _MyCoinPageState createState() => _MyCoinPageState();
}

class _MyCoinPageState extends State<MyCoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "我的金币",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Column(
          children: <Widget>[
            CoinHeader(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(
                    0, 41, 0, MediaQuery.of(context).padding.bottom),
                itemBuilder: (context, index) {
                  return CoinSection(
                    title: "交易明细",
                    emptyPlaceholder: "暂无交易记录～",
                    cells: <Widget>[
                      CoinCell(
                        icon: "images/ico_mygold_list_cell_cashout@3x.png",
                        name: "151****4547",
                        value: "-1880",
                        content: "2020-10-11",
                        subcontent: "17：48",
                        showLine: false,
                      ),
                    ],
                  );
                },
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
