import 'package:flutter/material.dart';

class TickPage extends StatefulWidget {
  TickPage({Key key}) : super(key: key);

  @override
  _TickPageState createState() => _TickPageState();
}

class _TickPageState extends State<TickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) {
            double itemSpace = 90;
            var itemWH = (orientation == Orientation.landscape
                    ? MediaQuery.of(context).size.height
                    : MediaQuery.of(context).size.width) -
                itemSpace * 2 -
                AppBar().preferredSize.height;
            return Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                bottom: AppBar().preferredSize.height,
                left: itemSpace,
                right: itemSpace,
              ),
              child: Wrap(
                runSpacing: 25,
                spacing: 25,
                children: [
                  Card(
                    elevation: 10.0,
                    color: Color.fromRGBO(21, 21, 21, 1),
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: itemWH,
                      height: itemWH,
                      child: Center(
                        child: Text(
                          "10",
                          style: TextStyle(
                            fontSize: 120,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    margin: EdgeInsets.zero,
                  ),
                  Card(
                    elevation: 10.0,
                    color: Color.fromRGBO(21, 21, 21, 1),
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: itemWH,
                      height: itemWH,
                    ),
                    margin: EdgeInsets.zero,
                  ),
                  Card(
                    elevation: 10.0,
                    color: Color.fromRGBO(21, 21, 21, 1),
                    shadowColor: Color.fromRGBO(0, 0, 0, 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: itemWH,
                      height: itemWH,
                    ),
                    margin: EdgeInsets.zero,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
