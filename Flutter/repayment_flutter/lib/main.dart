import 'package:flutter/material.dart';
import 'package:repayment_flutter/pages/home/homepage.dart';
import 'package:repayment_flutter/pages/mine/minepage.dart';
import 'package:repayment_flutter/public/public.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "还款管家",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<String> _tabItems = ["首页", "我的"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomePage(),
          MinePage(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _tabItems.map(
          (tab) {
            int index = _tabItems.indexOf(tab);
            return BottomNavigationBarItem(
              icon: index == 0
                  ? Icon(
                      Icons.home,
                    )
                  : Icon(
                      Icons.person,
                    ),
              title: Text(tab),
            );
          },
        ).toList(),
        currentIndex: _currentIndex,
        selectedItemColor: kMainColor,
        selectedFontSize: 10,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 10,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
