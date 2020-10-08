import 'package:flutter/material.dart';
import 'package:focus_tick/views/tick_cell.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _dataList = [
    {
      "icon": "",
      "name": "",
      "time": "",
      "creation": false,
    },
    {
      "icon": "",
      "name": "",
      "time": "",
      "creation": true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AppBar(
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          OrientationBuilder(
            builder: (context, orientation) {
              return GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: orientation == Orientation.landscape ? 4 : 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                padding: EdgeInsets.only(
                  left: (orientation == Orientation.landscape ? 0 : 12) +
                      MediaQuery.of(context).padding.left,
                  right: (orientation == Orientation.landscape ? 0 : 12) +
                      MediaQuery.of(context).padding.right,
                  top: orientation == Orientation.landscape
                      ? MediaQuery.of(context).padding.bottom
                      : MediaQuery.of(context).padding.top,
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
                children: _dataList.map((item) {
                  return Card(
                    elevation: 10.0,
                    color: Color.fromRGBO(21, 21, 21, 1),
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TickCell(
                      tick: item,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
