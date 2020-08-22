import 'package:flutter/cupertino.dart';
import 'package:yue_mei/public/public.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReceivedGifts extends StatelessWidget {
  Map account;

  ReceivedGifts({this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
      padding: EdgeInsets.fromLTRB(0, 30.5, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "收到礼物",
            style: TextStyle(
              color: rgba(51, 51, 51, 1),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}