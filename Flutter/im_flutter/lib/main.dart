import 'package:flutter/material.dart';
import 'package:im_flutter/home.dart';
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
  var _appID = "1400398568";

  /// 登录
  onLogin1() {
    TencentImPlugin.initStorage(identifier: "000002").then((_) => {});
    TencentImPlugin.login(
      identifier: "000002",
      userSig:
          "eJw1jcsKwjAURH*lZC3lNm0eFVyJSCErFffWxnCRaEhKGxT-XWPbWc7MmXmTkzrmAQ1ZZ4SN0ja7pqypbq28enUu4jYKxfeHViv1bPhLmcGKMZgNWWV-VEeHXv-ogjFGAWD2Q3e-OIddSiqAspaMyzkbtE93NIdlpUc7bdSVFCDE0sROP3q84QRAEiWfL3nEMeM_",
    )
        .then((value) => {
              print("登陆成功"),
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeTab();
                  },
                ),
                (route) => false,
              )
            })
        .catchError((error) {
      print("error:" + error.toString());
    });
  }

  onLogin() {
    TencentImPlugin.initStorage(identifier: "000002").then((_) => {});
    TencentImPlugin.login(
      identifier: "000001",
      userSig:
          "eJyrVgrxCdYrzkxXslJQcvMuC3Etdy5ISvQzCE5yLHYpTQo0NDNxSQwx8g7IzLEMyk9LDvDx96zyNrBV0lEAa02tKMgsSgXqNjQ1NTUyMDCAihenZCcWFGSmgGRMDAyMLS1MzSygcmWpRSDrjPQMYKaUZOZCzLA0sTCzMDEzg4pnpqTmlWSmZUI0GICAoVItAGYHMaE_",
    )
        .then((value) => {
              print("登陆成功"),
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return HomeTab();
                  },
                ),
                (route) => false,
              )
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
    // eJw1jdEKgjAYRl9Fdlvomptp0I0VWKZFdlGXo634EU22OYro3cu02-NxzvdCx23harihmYPidH8CYzd4lawT3RbZsx7Fpjx7cbnLPZ7anCTTQ7vIlpc5Gjs-VT4aUPJrTxhjBGM8cC1K3jQguoVi7EchpcGwWam6O*Lif8VA1TciGgbEZ-7AQcjawBV6gYsKatBGcXNX6P0B2iY16g__
    // https://pub.dev/packages/tencent_im_plugin/example
    TencentImPlugin.init(appid: _appID);
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
              child: Text("iOS登陆"),
            ),
            RaisedButton(
              onPressed: () {
                this.onLogin1();
              },
              child: Text("安卓登陆"),
            ),
          ],
        ),
      ),
    );
  }
}
