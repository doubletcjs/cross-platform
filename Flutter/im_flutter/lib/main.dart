import 'package:flutter/material.dart';
import 'package:tencent_im_plugin/enums/log_print_level.dart';
import 'package:tencent_im_plugin/tencent_im_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _messageListener(ListenerTypeEnum type, params) {
    print("type:" + "$type");
    print("params:" + "$params");
  }

  /// 登录
  onLogin() {
    TencentImPlugin.initStorage(identifier: "administrator").then((_) => {});
    TencentImPlugin.login(
      identifier: "administrator",
      userSig:
          "2bc826c1b6a9552d3ff9e4b173e72675117471312af725f693fbf4b1fd4cf011",
    )
        .then((value) => {
              print("登陆成功"),
            })
        .catchError((error) {
      print("error:" + error.toString());
    });
  }

  @override
  void initState() {
    super.initState();

    // SDKAppID 1400398446
    // 密钥 2bc826c1b6a9552d3ff9e4b173e72675117471312af725f693fbf4b1fd4cf011
    // https://pub.dev/packages/tencent_im_plugin/example
    TencentImPlugin.init(
        appid: "1400398446", logPrintLevel: LogPrintLevel.info);
    TencentImPlugin.addListener(_messageListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                this.onLogin();
              },
              child: Text("登陆"),
            )
          ],
        ),
      ),
    );
  }
}
