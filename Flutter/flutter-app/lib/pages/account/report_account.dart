import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';
import '../../public/public.dart';
import '../../public/networking.dart';
import '../mine/views/homepage/infosection_cell.dart';
import '../mine/views/homepage/cover_grid_view.dart';
import '../mine/api/member_api.dart';

class ReportAccount extends StatefulWidget {
  Map account;
  kVoidFunctionBlock reportHandle;
  ReportAccount({
    Key key,
    this.account,
    this.reportHandle,
  }) : super(key: key);

  @override
  _ReportAccountState createState() => _ReportAccountState();
}

class _ReportAccountState extends State<ReportAccount> {
  //举报类型id 1.低速骚扰 2.广告营销 3.虚假信息 4.其他
  List<String> _reportItems = [
    "色情",
    "诈骗",
    "广告骚扰",
    "敏感信息",
    "其他",
  ];
  int _currentIndex = -1; //举报原因index
  List _coverList = []; //图片列表
  TextEditingController _editingController = TextEditingController();

  //提交举报
  void _reportOnConfirm() {
    if (_currentIndex == -1) {
      showToast("请选择举报原因", context);
      return;
    }

    if (ObjectUtil.isEmptyString(_editingController.text)) {
      showToast("请描述相关情况", context);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    XsProgressHud.show(context);

    Map<String, Object> _params = {
      "report_user_id": "${this.widget.account['id']}",
      "type": "${_currentIndex + 1}",
      "content": "${_editingController.text}",
    };
    void _baseReportUpload() {
      MemberApi.report(_params, (data, msg) {
        if (data != null) {
          if (this.widget.reportHandle != null) {
            this.widget.reportHandle();
          }

          Future.delayed(Duration(milliseconds: 600), () {
            XsProgressHud.hide();
            Navigator.of(context).pop();
          });
        } else {
          XsProgressHud.hide();
          showToast("$msg", context);
        }
      });
    }

    //处理封面图片列表上传
    List _tempCoverList = List.from(_coverList);
    var index = 0;
    void _uploadCovers() {
      if (index == _tempCoverList.length) {
        _params["img"] =
            JsonDecoder().convert(JsonEncoder().convert(_tempCoverList));
        _baseReportUpload();
      } else {
        if (_tempCoverList[index] is List<int>) {
          List<int> _imageData = _tempCoverList[index];
          Networking.uploadFiles("/api/v1/upload", [_imageData], (data, msg) {
            if (data != null) {
              List urls = data;
              if (urls.length > 0) {
                _tempCoverList[index] = "${urls.first}";
                index += 1;

                _uploadCovers();
              } else {
                showToast("部分图片上传失败！请稍后重试。", context);
              }
            } else {
              showToast("部分图片上传失败！请稍后重试。", context);
            }
          });
        } else {
          index += 1;
          _uploadCovers();
        }
      }
    }

    if (_tempCoverList.length > 0) {
      _uploadCovers();
    } else {
      _params["img"] =
          JsonDecoder().convert(JsonEncoder().convert(_tempCoverList));
      _baseReportUpload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        title: "举报",
        elevation: 0.5,
        rightItems: [
          Center(
            child: Container(
              width: 54,
              height: 27,
              margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [rgba(255, 44, 96, 1), rgba(255, 114, 81, 1)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerLeft,
                ),
                borderRadius: BorderRadius.circular(27 / 2),
              ),
              child: FlatButton(
                padding: EdgeInsets.fromLTRB(0, 4.5, 0, 4.5),
                onPressed: () {
                  this._reportOnConfirm();
                },
                child: Text(
                  "提交",
                  style: TextStyle(
                    color: rgba(255, 255, 255, 1),
                    fontSize: 13,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27 / 2),
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          //举报原因section
          InfoBaseSection(
            title: "举报原因",
          ),
          Column(
            children: _reportItems.map((item) {
              int index = _reportItems.indexOf(item);
              return InfoBaseCell(
                name: item,
                hideArrow: true,
                valueWidget: Image.asset(
                  index == _currentIndex
                      ? "images/report_checked@3x.png"
                      : "images/report_check@3x.png",
                  width: 17,
                  height: 17,
                ),
                tapHandle: () {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              );
            }).toList(),
          ),
          //描述情况section
          InfoBaseSection(
            title: "描述情况",
          ),
          //举报内容
          Container(
            padding: EdgeInsets.fromLTRB(15, 15, 15, 16.5),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 2, 10, 12.5),
              decoration: BoxDecoration(
                color: rgba(246, 246, 246, 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                maxLines: 7,
                controller: _editingController,
                style: TextStyle(
                  fontSize: 13,
                  color: rgba(51, 51, 51, 1),
                ),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: "请在此描述情况，请放心，我们不会透露您的信息",
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: rgba(172, 172, 172, 1),
                  ),
                ),
              ),
            ),
          ),
          //截图
          Container(
            padding: EdgeInsets.fromLTRB(15.5, 0, 15.5, 33.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "若有截图请添加：",
                  style: TextStyle(
                    fontSize: 17,
                    color: rgba(0, 0, 0, 1),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 7.5,
                ),
                Text(
                  "上传截图，处理更快",
                  style: TextStyle(
                    fontSize: 12,
                    color: rgba(102, 102, 102, 1),
                  ),
                ),
                SizedBox(
                  height: 7.5,
                ),
                //图片列表
                CoverGridView(
                  coverAddition: true,
                  coverList: _coverList,
                  gridWidth: MediaQuery.of(context).size.width - 15.5 * 2,
                  updateHandle: (list) {
                    setState(() {
                      _coverList = List.from(list);
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
                      "images/tishi@3x.png",
                      width: 15.5,
                      height: 15.5,
                    ),
                    SizedBox(
                      width: 4.5,
                    ),
                    Text(
                      "经核实我们会对违规账户进行警告或封号处理",
                      style: TextStyle(
                        fontSize: 12,
                        color: rgba(51, 51, 51, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
