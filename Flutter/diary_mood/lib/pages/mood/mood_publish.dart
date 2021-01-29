import 'package:common_utils/common_utils.dart';
import 'package:diary_mood/pages/topic/topic_list.dart';
import 'package:diary_mood/public/public.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MoodPublish extends StatefulWidget {
  Map topic;
  MoodPublish({
    Key key,
    this.topic,
  }) : super(key: key);

  @override
  _MoodPublishState createState() => _MoodPublishState();
}

class _MoodPublishState extends State<MoodPublish> {
  TextEditingController _textEditingController = TextEditingController();
  bool _anonymous = false;
  bool _publishAble = false;

  // 发布
  void _onConfirm() {}

  // 选择话题
  void _topicSelect() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return TopicList(
          topicHandle: (object) {
            this.widget.topic = {"": ""};
            setState(() {});
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: AppBar(
        title: Text("发布"),
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.close,
          ),
        ),
        actions: [
          Row(
            children: [
              Container(
                height: 28,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _publishAble == true
                        ? [rgba(255, 44, 96, 1), rgba(255, 114, 81, 1)]
                        : [rgba(243, 243, 243, 1), rgba(243, 243, 243, 1)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(28 / 2),
                ),
                alignment: Alignment.center,
                child: FlatButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  padding: EdgeInsets.zero,
                  minWidth: 48,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28 / 2),
                  ),
                  onPressed: _publishAble == true
                      ? () {
                          this._onConfirm();
                        }
                      : null,
                  child: Text(
                    "发布",
                    style: TextStyle(
                      fontSize: 13,
                      color: _publishAble == true
                          ? rgba(255, 255, 255, 1)
                          : rgba(135, 135, 135, 1),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 13,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // 输入框
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 21, right: 21),
                child: TextField(
                  autofocus: true,
                  maxLines: null,
                  expands: true,
                  controller: _textEditingController,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: "说点什么～",
                    hintStyle: TextStyle(
                      color: rgba(166, 163, 163, 1),
                      fontSize: 16,
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    counterText: "",
                  ),
                  onChanged: (value) {
                    bool allReturn = true;
                    List<String> list = value.split("");
                    for (var i = 0; i < list.length; i++) {
                      if (list[i] != "\n") {
                        allReturn = false;
                      }
                    }

                    _publishAble = allReturn == false &&
                        ObjectUtil.isEmptyString(value) == false;
                    setState(() {});
                  },
                ),
              ),
            ),
            // 功能框
            Container(
              height: 54 + MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: rgba(239, 239, 239, 1),
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 话题
                    FlatButton(
                      onPressed: () {
                        this._topicSelect();
                      },
                      minWidth: 0,
                      height: 29,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.only(left: 12, right: 12),
                      color: rgba(249, 249, 248, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(29 / 2),
                      ),
                      child: Container(
                        height: 29,
                        constraints: BoxConstraints(
                          maxWidth: 260,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    (ObjectUtil.isEmpty(this.widget.topic) ==
                                                false &&
                                            this.widget.topic.length > 0)
                                        ? 260 - 22.0
                                        : 260,
                              ),
                              child: Text(
                                (ObjectUtil.isEmpty(this.widget.topic) ==
                                            false &&
                                        this.widget.topic.length > 0)
                                    ? "#话题话题话题话题话题话题话题话题话题话题话题话题话题话题话题#"
                                    : "#点击添加",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      (ObjectUtil.isEmpty(this.widget.topic) ==
                                                  false &&
                                              this.widget.topic.length > 0)
                                          ? rgba(0, 0, 0, 1)
                                          : rgba(174, 174, 174, 1),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            (ObjectUtil.isEmpty(this.widget.topic) == false &&
                                    this.widget.topic.length > 0)
                                ? FlatButton(
                                    minWidth: 0,
                                    height: 22,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      this.widget.topic = null;
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: rgba(179, 179, 179, 1),
                                      size: 22,
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    // 匿名
                    Row(
                      children: [
                        Text("匿名"),
                        SizedBox(
                          width: 8,
                        ),
                        FlatButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.zero,
                          minWidth: 0,
                          height: 18,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18 / 2),
                          ),
                          child: Image.asset(
                            _anonymous == true
                                ? "images/anonymous_on@3x.png"
                                : "images/anonymous_off@3x.png",
                            width: 36,
                          ),
                          onPressed: () {
                            _anonymous = !_anonymous;
                            setState(() {});
                          },
                        )
                      ],
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
