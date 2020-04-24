import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class CommunityOptionBottomSheet extends StatelessWidget {
  const CommunityOptionBottomSheet({Key key}) : super(key: key);

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: rgba(0, 0, 0, 0),
      builder: (context) {
        return this;
      },
    );
  }

  List<Widget> _optionsWidget(BuildContext context) {
    return ["发布动态", "发布视频"].map(
      (option) {
        return Column(
          children: <Widget>[
            buttonWidget(
              Container(
                width: 75,
                height: 75,
                padding: EdgeInsets.all(2),
                child: Image.asset(
                  option == "发布动态"
                      ? "images/fabudongtai@3x.png"
                      : "images/fabushiping@3x.png",
                ),
              ),
              context,
              onTap: () {},
              radius: BorderRadius.circular(77 / 2),
              color: Colors.white,
            ),
            SizedBox(
              height: 13,
            ),
            Text(
              option,
              style: TextStyle(
                fontSize: 14,
                color: rgba(136, 136, 136, 1),
              ),
            ),
          ],
        );
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 174 + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 57,
            right: 57,
            top: 37,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _optionsWidget(context),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(44 / 2),
              child: InkWell(
                borderRadius: BorderRadius.circular(44 / 2),
                child: Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "images/mine_close@3x.png",
                    width: 18,
                    height: 18,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
