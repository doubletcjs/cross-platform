import 'package:flutter/material.dart';
import 'package:hksy_flutter/pages/galaxy/galaxypage.dart';
import 'package:hksy_flutter/pages/home/homepage.dart';
import 'package:hksy_flutter/pages/mine/minepage.dart';
import 'package:hksy_flutter/pages/store/storepage.dart';
import 'package:hksy_flutter/public/public.dart';

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
      title: "华科闪云",
      home: Scaffold(
        body: IndexedStack(
          children: <Widget>[
            HomePage(),
            StorePage(),
            GalaxyPage(),
            MinePage(),
          ],
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/ico_tab_home_normal@3x.png",
                width: 22,
                height: 22,
              ),
              activeIcon: Image.asset(
                "images/ico_tab_home_selected@3x.png",
                width: 22,
                height: 22,
              ),
              title: Text(
                "首页",
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/ico_tab_market_normal@3x.png",
                width: 22,
                height: 22,
              ),
              activeIcon: Image.asset(
                "images/ico_tab_market_selected@3x.png",
                width: 22,
                height: 22,
              ),
              title: Text(
                "商城",
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/ico_tab_galaxy_normal@3x.png",
                width: 22,
                height: 22,
              ),
              activeIcon: Image.asset(
                "images/ico_tab_galaxy_selected@3x.png",
                width: 22,
                height: 22,
              ),
              title: Text(
                "Galaxy",
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "images/ico_tab_my_normal@3x.png",
                width: 22,
                height: 22,
              ),
              activeIcon: Image.asset(
                "images/ico_tab_my_selected@3x.png",
                width: 22,
                height: 22,
              ),
              title: Text(
                "我的",
              ),
            )
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedItemColor: kMainColor,
          unselectedItemColor: rgba(145, 152, 173, 1),
          elevation: 0,
          backgroundColor: kMainBackgroundColor,
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

/*
class MyApp extends StatelessWidget {
  int _currentIndex = 0;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[HomePage(), StorePage(), GalaxyPage(), MinePage()],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("images/ico_tab_home_normal@3x.png"),
            activeIcon: Image.asset("images/ico_tab_home_selected@3x.png"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/ico_tab_market_normal@3x.png"),
            activeIcon: Image.asset("images/ico_tab_market_selected@3x.png"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/ico_tab_galaxy_normal@3x.png"),
            activeIcon: Image.asset("images/ico_tab_galaxy_selected@3x.png"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/ico_tab_my_normal@3x.png"),
            activeIcon: Image.asset("images/ico_tab_my_selected@3x.png"),
          )
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          set
        },
      ),
    );
  }
}

*/
