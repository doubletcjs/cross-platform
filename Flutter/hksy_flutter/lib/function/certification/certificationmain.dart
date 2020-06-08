import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class CertificationMain extends StatefulWidget {
  int type = 0;
  CertificationMain({Key key, this.type = 0}) : super(key: key);

  @override
  _CertificationMainState createState() => _CertificationMainState();
}

class _CertificationMainState extends State<CertificationMain> {
  int _currentIndex = 0;

  List<String> _certificationItems = [
    "身份认证",
    "绑定手机",
    "绑定银行卡",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: this.widget.type == 0 ? "身份证验证" : "其它证验证",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(44, 0, 44, 0),
            color: rgba(28, 35, 63, 1),
            height: 72.5,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: 24,
                  left: 19.5 + 19.5 / 2 + ((60 + 19.5 / 2) * 2) * 1,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 60,
                        height: 2,
                        color: rgba(145, 152, 173, 1),
                      ),
                      Container(
                        width: 60,
                        height: 2,
                        color: rgba(145, 152, 173, 1),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _certificationItems.map((item) {
                    var index = _certificationItems.indexOf(item);
                    return Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 19.5,
                              height: 19.5,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? rgba(23, 96, 255, 1)
                                    : rgba(145, 152, 173, 1),
                                borderRadius: BorderRadius.circular(19.5 / 2),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${index + 1}",
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: rgba(255, 255, 255, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              item,
                              style: TextStyle(
                                fontSize: 11.5,
                                color: _currentIndex == index
                                    ? rgba(255, 255, 255, 1)
                                    : rgba(145, 152, 173, 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(
                12, 0, 12, 48.5 + MediaQuery.of(context).padding.bottom),
            height: 49,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: rgba(23, 96, 255, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              child: Text(
                "下一步",
                style: TextStyle(
                  color: rgba(255, 255, 255, 1),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
