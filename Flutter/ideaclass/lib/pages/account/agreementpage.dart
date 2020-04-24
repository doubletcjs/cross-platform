import 'package:flutter/material.dart';
// import 'package:flutter_native_web/flutter_native_web.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/public/public.dart';

class AgreementPage extends StatefulWidget {
  AgreementPage({Key key}) : super(key: key);

  @override
  _AgreementPageState createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  String _htmlString = "";

  // WebController _webController;
  // FlutterNativeWeb _nativeWeb;

  @override
  void initState() {
    super.initState();

    // _nativeWeb = FlutterNativeWeb(
    //   onWebCreated: (controller) {
    //     _webController = controller;
    //     _webController.loadData(_htmlString);
    //     // _webController.loadUrl("https://www.baidu.com");
    //     // _webController.onPageStarted.listen(
    //     //   (url) => print("Loading $url"),
    //     // );
    //     // _webController.onPageFinished.listen(
    //     //   (url) => print("Finished loading $url"),
    //     // );
    //   },
    // );

    Future.delayed(
      Duration(milliseconds: 10),
      () {
        showHUD();
        AccountApi().getRegisterAgreement(
          (data, msg) {
            if (data != null) {
              _htmlString = data["value"];
              hideHUD();
              setState(() {});
            } else {
              showToast(msg, context);
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "用户协议",
      ),
      // body: _nativeWeb,
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            HtmlWidget(
              _htmlString,
              webView: true,
            ),
          ],
        ),
      ),
    );
  }
}
