import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:time_flies/pages/dynamic/views/image_grid_view.dart';
import 'package:time_flies/pages/topic/topic_selection.dart';
import 'package:time_flies/public/public.dart';

class DynamicPostPage extends StatefulWidget {
  DynamicPostPage({Key key}) : super(key: key);

  @override
  _DynamicPostPageState createState() => _DynamicPostPageState();
}

class _DynamicPostPageState extends State<DynamicPostPage> {
  bool _canSubmit = false; // 是否可发布
  TextEditingController _editingController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  List _imageList = []; // 图片列表
  bool _imageShow = true;

  // 发布状态
  void _checkSubmitStatus() {
    setState(() {
      _canSubmit = false;
    });
  }

  // 标签
  void _topicSelection() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return TopicSelection();
      }),
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      _focusNode.addListener(() {
        if (_focusNode.hasFocus) {
          //有焦点
          setState(() {
            _imageShow = false;
          });
        } else {
          //失去焦点
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
        leftItems: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "取消",
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
        rightItems: [
          Container(
            width: 56,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28 / 2),
              gradient: LinearGradient(
                colors: _canSubmit
                    ? [
                        rgba(255, 44, 96, 1),
                        rgba(255, 114, 81, 1), //rgba(243, 243, 243, 1)
                      ]
                    : [rgba(243, 243, 243, 1), rgba(243, 243, 243, 1)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: FlatButton(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28 / 2),
              ),
              onPressed: _canSubmit ? () {} : null,
              child: Text(
                "发布",
                style: TextStyle(
                  color: _canSubmit ? Colors.white : Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _imageShow = false;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 内容
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: TextField(
                  maxLines: 10,
                  autofocus: true,
                  controller: _editingController,
                  focusNode: _focusNode,
                  style: TextStyle(
                    color: rgba(0, 0, 0, 1),
                    fontSize: 16,
                  ),
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "简单描述一下你的作品吧～",
                    hintStyle: TextStyle(
                      color: rgba(166, 163, 163, 1),
                      fontSize: 14,
                    ),
                  ),
                  onChanged: (text) {
                    _checkSubmitStatus();
                  },
                ),
              ),
            ),
            // 图片列表
            _imageShow == true
                ? Container(
                    padding: EdgeInsets.only(
                      left: 20.5,
                      right: 20.5,
                      bottom: 4,
                    ),
                    child: Stack(
                      children: [
                        ImageGridView(
                          gridAddition: true,
                          gridList: List.from(_imageList),
                          maxColumn: 3,
                          itemSpace: 8,
                          gridWidth:
                              MediaQuery.of(context).size.width - 20.5 * 2.0,
                          updateHandle: (list) {
                            setState(() {
                              _imageList = List.from(list);
                            });
                            _checkSubmitStatus();
                          },
                        ),
                        _imageList.length > 0
                            ? Positioned(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image.asset(
                                    "images/icn_cover@3x.png",
                                    width: 30,
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : Container(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 0.5,
                    color: rgba(239, 239, 239, 1),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 图片
                  Container(
                    width: 64,
                    height: 58,
                    child: Stack(
                      children: [
                        Positioned(
                          width: 64,
                          height: 58,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              if (_focusNode.canRequestFocus) {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                Future.delayed(Duration(milliseconds: 200), () {
                                  setState(() {
                                    _imageShow = !_imageShow;
                                  });
                                });
                              } else {
                                setState(() {
                                  _imageShow = !_imageShow;
                                });
                              }
                            },
                            child: Icon(
                              Icons.image,
                            ),
                          ),
                        ),
                        // 图片数
                        _imageList.length > 0
                            ? Positioned(
                                right: 4,
                                top: 4,
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(4, 0, 4, 1),
                                  decoration: BoxDecoration(
                                    color: rgba(255, 73, 54, 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  constraints: BoxConstraints(
                                    minHeight: 16,
                                    minWidth: 16,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${_imageList.length}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: rgba(255, 255, 255, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  // 标签
                  Container(
                    width: 64,
                    height: 58,
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        this._topicSelection();

                        setState(() {
                          _imageShow = false;
                        });
                      },
                      child: Icon(
                        Icons.label,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: ChipsInput(
                        maxChips: 5,
                        autofocus: true,
                        keyboardAppearance: Brightness.light,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        textStyle: TextStyle(
                          height: 1.7,
                          fontFamily: "Roboto",
                          fontSize: 16,
                        ),
                        chipBuilder: (context, state, data) {
                          // 所选标签
                          return InputChip(
                            label: Text("$data"),
                            onDeleted: () {
                              state.deleteChip(data);
                            },
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          );
                        },
                        suggestionBuilder: (context, state, data) {
                          // 展示符合条件的数据
                          // 点击添加标签数据 state.selectSuggestion(data),
                          return ListTile(
                            title: Text("$data"),
                            onTap: () {
                              state.selectSuggestion(data);
                            },
                          );
                        },
                        findSuggestions: (query) {
                          // query 搜索条件，根据条件获取数据
                          return [
                            "a",
                            "b",
                            "c",
                            "d",
                            "e",
                            "f",
                            "g",
                            "h",
                            "1",
                            "2",
                            "3",
                            "4",
                            "5",
                            "6",
                            "7"
                          ];
                        },
                        onChanged: (data) {
                          kLog("$data");
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
