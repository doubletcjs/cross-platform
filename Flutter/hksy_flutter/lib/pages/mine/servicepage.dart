import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/mine/contractpage.dart';
import 'package:hksy_flutter/pages/mine/customerservice.dart';
import 'package:hksy_flutter/pages/personal/views/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "联系客服",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        children: <Widget>[
          InfoSection(
            cells: <Widget>[
              InfoCell(
                name: "下载合同",
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ContractPage();
                      },
                    ),
                  );
                },
              ),
              InfoCell(
                name: "联系客服",
                showLine: false,
                tapHandle: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CustomerService();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
