import 'package:corner_app/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StickyNavigatorBar extends StatefulWidget {
  Widget lefts;
  Widget rights;
  double backgroudOpacity = 0.0;
  double barHeight;

  StickyNavigatorBar({
    Key key,
    @required this.lefts,
    @required this.rights,
    @required this.barHeight,
    this.backgroudOpacity = 0.0,
  }) : super(key: key);

  @override
  _StickyNavigatorBarState createState() => _StickyNavigatorBarState();
}

class _StickyNavigatorBarState extends State<StickyNavigatorBar> {
  @override
  void initState() {
    if (this.widget.barHeight == null || this.widget.barHeight == 0.0) {
      setState(() {
        this.widget.barHeight = AppBar().preferredSize.height;
      });
    }

    super.initState();

    if (this.widget.lefts == null) {
      this.widget.lefts = Container(
        width: this.widget.barHeight,
        height: this.widget.barHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(this.widget.barHeight / 2),
        ),
        child: FlatButton(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(this.widget.barHeight / 2),
          ),
          child: Image.asset(
            "images/base_back_white@3x.png",
            width: 11,
            height: 20,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
    }

    if (this.widget.rights == null) {
      this.widget.rights = Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.barHeight + MediaQuery.of(context).padding.top,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Opacity(
              opacity: this.widget.backgroudOpacity,
              child: Stack(
                children: [
                  Image.asset(
                    "images/homepages_default_bg.png",
                    height: 217 + MediaQuery.of(context).padding.top,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: rgba(0, 0, 0, 0.4),
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top,
                    ),
                    height: 217 + MediaQuery.of(context).padding.top,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                this.widget.lefts,
                this.widget.rights,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
