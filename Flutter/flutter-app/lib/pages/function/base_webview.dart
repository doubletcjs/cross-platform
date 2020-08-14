import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import '../../public/public.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class BaseWebView extends StatefulWidget {
  String url = "";
  String title = "";
  BaseWebView({
    Key key,
    this.url = "",
    this.title = "",
  }) : super(key: key);

  @override
  _BaseWebViewState createState() => _BaseWebViewState();
}

class _BaseWebViewState extends State<BaseWebView> {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: this.widget.title,
      ),
      body: Stack(
        children: [
          WebViewPlus(
            onWebViewCreated: (controller) {
              controller.loadUrl(
                  ObjectUtil.isEmptyString(this.widget.url) == true
                      ? "https://www.baidu.com"
                      : this.widget.url);
            },
            onPageFinished: (url) {
              setState(() {
                _loading = false;
              });
            },
            onPageStarted: (url) {
              setState(() {
                _loading = true;
              });
            },
          ),
          _loading == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(),
        ],
      ),
    );
  }
}
