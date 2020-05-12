import 'package:flutter/material.dart';
import 'package:mindor_flutter/pages/home/homepage.dart';
import 'package:mindor_flutter/pages/mall/mallpage.dart';
import 'package:mindor_flutter/pages/mine/minepage.dart';
import 'package:mindor_flutter/pages/model/modepage.dart';
import 'package:mindor_flutter/pages/remote/remotepage.dart';
import 'package:mindor_flutter/public/public.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "名豆之约",
      home: Scaffold(
        body: IndexedStack(
          children: <Widget>[
            HomePage(),
            ModelPage(),
            RemotePage(),
            MallPage(),
            MinePage(),
          ],
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                "首页",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.view_module,
              ),
              title: Text(
                "模式",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_remote,
              ),
              title: Text(
                "遥控",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_mall,
              ),
              title: Text(
                "商城",
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text(
                "我",
              ),
            ),
          ],
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: kMainColor,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          iconSize: 22,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
