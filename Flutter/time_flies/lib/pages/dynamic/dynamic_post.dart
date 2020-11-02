import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_flies/pages/dynamic/dynamic_locate.dart';
import 'package:time_flies/pages/dynamic/views/image_grid_view.dart';
import 'package:time_flies/pages/topic/topic_selection.dart';
import 'package:time_flies/public/public.dart';

class DynamicPostPage extends StatefulWidget {
  DynamicPostPage({Key key}) : super(key: key);

  @override
  _DynamicPostPageState createState() => _DynamicPostPageState();
}

class _DynamicPostPageState extends State<DynamicPostPage> {
  bool _anonymous = false; // 是否匿名
  List _labelList = []; // 所选标签
  var _location;
  bool _canSubmit = false; // 是否可发布
  String _content = ""; // 动态内容

  ImageGridView _gridView; // 图片列表
  List _imageList = [];

  // 发布状态
  void _checkSubmitStatus() {
    setState(() {
      _canSubmit = false;
    });

    if (ObjectUtil.isEmptyString(_content) == false &&
        _location != null &&
        _labelList.length > 0) {
      setState(() {
        _canSubmit = true;
      });
    }
  }

  // 标签
  void _labelSection() {
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return TopicSelection();
      }),
    );
  }

  // 位置
  void _locationSection() {
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return DynamicLocatePage();
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _gridView = ImageGridView(
          gridAddition: true,
          gridList: List.from(_imageList),
          maxColumn: 3,
          itemSpace: 11,
          gridWidth: MediaQuery.of(context).size.width - 20.5 * 2,
          updateHandle: (list) {
            setState(() {
              _imageList = List.from(list);
            });
          },
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        // defaultBack: true,
        title: "发布动态",
        leftItems: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
        rightItems: [
          Container(
            width: 48,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28 / 2),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28 / 2),
              ),
              onPressed: _canSubmit == true ? () {} : null,
              child: Image.asset(
                _canSubmit == true
                    ? "images/dynamic_send_sel@3x.png"
                    : "images/dynamic_send@3x.png", //dynamic_send_sel@3x.png
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 2.5),
              child: Text(
                "描述",
                style: TextStyle(
                  fontSize: 16,
                  color: rgba(83, 83, 83, 1),
                ),
              ),
            ),
            // 内容
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: TextField(
                maxLines: 6,
                style: TextStyle(
                  color: rgba(0, 0, 0, 1),
                  fontSize: 16,
                ),
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "0/200",
                  hintStyle: TextStyle(
                    color: rgba(166, 163, 163, 1),
                    fontSize: 14,
                  ),
                ),
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(280) //限制长度
                ],
                onChanged: (text) {
                  setState(() {
                    _content = text;
                  });

                  this._checkSubmitStatus();
                },
              ),
            ),
            // 图片
            _gridView == null
                ? Container()
                : Container(
                    padding: EdgeInsets.only(
                      left: 20.5,
                      right: 20.5,
                    ),
                    child: _gridView,
                  ),
            // 位置
            Container(
              margin: EdgeInsets.fromLTRB(20, 51, 20, 0),
              alignment: Alignment.centerLeft,
              height: 29,
              child: FlatButton.icon(
                padding: EdgeInsets.fromLTRB(11, 6, 11, 6),
                color: rgba(249, 249, 248, 1),
                onPressed: () {
                  this._locationSection();
                },
                icon: Image.asset(
                  _location == null
                      ? "images/dynamic_post_dingwei@3x.png"
                      : "images/dynamic_post_dingwei_sel@3x.png", //dynamic_post_dingwei_sel@3x.png
                  width: 10,
                  height: 12,
                ),
                label: Container(
                  constraints: BoxConstraints(
                    maxWidth: 280,
                  ),
                  child: Text(
                    _location == null ? "点击添加位置" : "$_location",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: _location == null
                          ? rgba(174, 174, 174, 1)
                          : rgba(0, 0, 0, 1),
                      fontSize: 12,
                    ),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29 / 2),
                ),
              ),
            ),
            // 选择主题标签
            Container(
              margin: EdgeInsets.fromLTRB(20, 13.5, 20, 0),
              child: InkWell(
                onTap: () {
                  this._labelSection();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        width: 0.5,
                        color: rgba(239, 239, 239, 1),
                      ),
                      bottom: BorderSide(
                        width: 0.5,
                        color: rgba(239, 239, 239, 1),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(
                    top: 18,
                    bottom: 18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "选择主题标签",
                              style: TextStyle(
                                color: rgba(37, 37, 37, 1),
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Image.asset(
                            "images/Arrow@3x.png",
                            width: 5.63,
                            height: 10.22,
                          ),
                        ],
                      ),
                      // 所选标签
                      _labelList.length > 0
                          ? Container(
                              margin: EdgeInsets.only(
                                top: 10.5,
                              ),
                              child: Wrap(
                                runSpacing: 10,
                                spacing: 10,
                                children: _labelList.map((label) {
                                  return Container(
                                    height: 26,
                                    padding: EdgeInsets.only(
                                      left: 13,
                                      right: 13,
                                    ),
                                    decoration: BoxDecoration(
                                      color: rgba(234, 236, 240, 1),
                                      borderRadius:
                                          BorderRadius.circular(13.25),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: 200,
                                          ),
                                          child: Text(
                                            label,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: rgba(16, 16, 16, 1),
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            // 匿名
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 44),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: rgba(239, 239, 239, 1),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                  top: 18,
                  bottom: 18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "匿名",
                        style: TextStyle(
                          color: rgba(25, 25, 25, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 18,
                      margin: EdgeInsets.only(right: 18 / 2),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18 / 2),
                        ),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          setState(() {
                            _anonymous = !_anonymous;
                          });
                        },
                        child: Image.asset(
                          _anonymous == true
                              ? "images/dynamic_anonymous_open@3x.png"
                              : "images/dynamic_anonymous_close@3x.png", //dynamic_anonymous_open@3x.png
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
