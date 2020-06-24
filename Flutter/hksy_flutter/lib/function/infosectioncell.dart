import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class InfoCell extends StatelessWidget {
  String name = "";
  String value = "";
  bool showArrow = true;
  bool isPortrait = false;
  bool showLine = true;
  Widget rightChild;
  Widget leftChild;
  kVoidFunctionBlock tapHandle;
  EdgeInsets padding = EdgeInsets.fromLTRB(0, 20, 0, 20);
  Widget icon;

  InfoCell({
    Key key,
    this.name = "",
    this.value = "",
    this.showArrow = true,
    this.isPortrait = false,
    this.showLine = true,
    this.tapHandle,
    this.rightChild,
    this.leftChild,
    this.padding,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (padding == null) {
      padding = EdgeInsets.fromLTRB(0, 20, 0, 20);
    }

    return InkWell(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: showLine == false
              ? Border()
              : Border(
                  bottom: BorderSide(
                    color: rgba(21, 25, 54, 1), //rgba(21, 25, 54, 1)
                    width: 1,
                  ),
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: leftChild != null
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: <Widget>[
            leftChild != null
                ? Expanded(
                    child: leftChild,
                  )
                : Row(
                    children: <Widget>[
                      icon != null ? icon : Container(),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
            rightChild != null
                ? rightChild
                : Row(
                    children: <Widget>[
                      isPortrait == true
                          ? ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl: value,
                                width: 59,
                                height: 59,
                                fit: BoxFit.cover,
                                placeholder: (context, url) {
                                  return Image.asset(
                                    "images/default_avatar@3x.png",
                                    width: 59,
                                    height: 59,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                              borderRadius: BorderRadius.circular(59 / 2),
                            )
                          : value.length > 0
                              ? Text(
                                  value,
                                  style: TextStyle(
                                    color: rgba(145, 152, 173, 1),
                                    fontSize: 15,
                                  ),
                                )
                              : Container(),
                      SizedBox(
                        width: ((value.length > 0 || isPortrait == true) &&
                                showArrow == true)
                            ? 12
                            : 0,
                      ),
                      showArrow == true
                          ? Image.asset(
                              "images/right_arrow@3x.png",
                              width: 18,
                              fit: BoxFit.fitWidth,
                            )
                          : Container(),
                    ],
                  ),
          ],
        ),
      ),
      onTap: () {
        if (tapHandle != null) {
          tapHandle();
        }
      },
    );
  }
}

class InfoSection extends StatelessWidget {
  List<Widget> cells = [];
  EdgeInsets padding = EdgeInsets.fromLTRB(24.5, 0, 24.5, 0);
  InfoSection({
    Key key,
    this.cells,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (padding == null) {
      padding = padding = EdgeInsets.fromLTRB(24.5, 0, 24.5, 0);
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: rgba(28, 35, 63, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Column(
        children: cells,
      ),
    );
  }
}
