import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/public.dart';

class BillEditorialHeader extends StatefulWidget {
  BillEditorialHeader({Key key}) : super(key: key);

  _BillEditorialHeaderState _state;

  @override
  _BillEditorialHeaderState createState() {
    _state = _BillEditorialHeaderState();
    return _state;
  }

  void reloadNumber(String number) {
    _state.setState(() {
      _state._number = number;
    });
  }
}

class _BillEditorialHeaderState extends State<BillEditorialHeader> {
  String _number = "";

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      padding: EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _number.length > 0 ? _number : "0.00",
            style: TextStyle(
              fontSize: 30,
              color: _number.length > 0 ? Colors.white : Colors.black45,
              fontFamily: "Oswald",
            ),
          ),
          Text(
            "每期还款金额（元）",
            style: TextStyle(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Row(),
        ],
      ),
    );
  }
}
