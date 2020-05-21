import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class ContractPage extends StatefulWidget {
  ContractPage({Key key}) : super(key: key);

  @override
  _ContractPageState createState() => _ContractPageState();
}

class _ContractPageState extends State<ContractPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "合同下载",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
              height: 62,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                    "images/word@3x.png",
                    width: 22.5,
                    height: 22.5,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "20191029HKJDJHF94180000041",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: rgba(255, 255, 255, 1),
                        fontSize: 13,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "images/ico-download@3x.png",
                    width: 15,
                    height: 15.75,
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.fromLTRB(44.5, 0, 12, 0),
              child: Container(
                height: 1,
                color: rgba(145, 152, 173, 0.2),
              ),
            );
          },
          itemCount: 30),
    );
  }
}
