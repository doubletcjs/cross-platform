import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'inputavatar.dart';
import '../../public/public.dart';

class InfoInputPage extends StatefulWidget {
  InfoInputPage({Key key}) : super(key: key);

  @override
  _InfoInputPageState createState() => _InfoInputPageState();
}

class _InfoInputPageState extends State<InfoInputPage> {
  TextEditingController _dateEditingController = TextEditingController();
  int _maxLength = 80; //签名长度
  bool _nextAviable = false; //是否填写完毕
  Map _infoPackage = {
    "name": "",
    "birthdate": "",
    "gender": -1, //性别 0 女 1 男
    "signature": "",
  };

  //检测输入数据
  void _checkInfoInput() {
    bool _didAviable = true;
    _infoPackage.forEach((key, value) {
      if (key == "gender") {
        if (value == -1) {
          _didAviable = false;
        }
      } else {
        if (ObjectUtil.isEmptyString(value) == true || "$value".length == 0) {
          _didAviable = false;
        }
      }
    });

    setState(() {
      _nextAviable = _didAviable;
    });
  }

  //出生日期
  void _borndaySelection() {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime _date = DateTime.now();
    if (ObjectUtil.isEmptyString(_infoPackage["birthdate"]) == false) {
      _date = DateTime.parse(_infoPackage["birthdate"]);
    }

    DatePicker.showDatePicker(context,
        dateFormat: "yyyy年-M月-d日",
        initialDateTime: _date,
        pickerTheme: DateTimePickerTheme(
          showTitle: false,
          backgroundColor: rgba(255, 255, 255, 1),
          pickerHeight: 216,
          itemTextStyle: TextStyle(
            fontSize: 23,
            color: rgba(0, 0, 0, 1),
            fontWeight: FontWeight.w400,
          ),
          itemHeight: 40,
        ), onChange: (dateTime, selectedIndex) {
      setState(() {
        String _dataStr = DateUtil.formatDate(dateTime, format: "yyyy-MM-dd");
        _infoPackage["birthdate"] = _dataStr;
        _dateEditingController.text = _dataStr;

        this._checkInfoInput();
      });
    }, onClose: () {
      setState(() {
        if (ObjectUtil.isEmptyString(_infoPackage["birthdate"]) == true) {
          _infoPackage["birthdate"] =
              DateUtil.formatDate(_date, format: "yyyy-MM-dd");
          _dateEditingController.text = _infoPackage["birthdate"];
        }

        this._checkInfoInput();
      });
    });
  }

  //下一步
  void _onConfirm() {
    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return InputAvatarPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(23, 15.5, 23, 112),
          children: <Widget>[
            Text(
              "填写资料",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: rgba(51, 51, 51, 1),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40.5,
            ),
            //呢称
            TextField(
              style: TextStyle(
                color: rgba(51, 51, 51, 1),
                fontSize: 14,
              ),
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.3,
                    color: rgba(188, 188, 188, 1),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 0.3,
                    color: rgba(188, 188, 188, 1),
                  ),
                ),
                hintText: "填写呢称",
                hintStyle: TextStyle(
                  color: rgba(171, 171, 171, 1),
                  fontSize: 14,
                ),
              ),
              onChanged: (text) {
                setState(() {
                  _infoPackage["name"] = text;
                  this._checkInfoInput();
                });
              },
            ),
            SizedBox(
              height: 15,
            ),
            //生日
            InkWell(
              onTap: () {
                this._borndaySelection();
              },
              child: Stack(
                children: <Widget>[
                  TextField(
                    enabled: false,
                    controller: _dateEditingController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.3,
                          color: rgba(188, 188, 188, 1),
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 0.3,
                          color: rgba(188, 188, 188, 1),
                        ),
                      ),
                      hintText: "选择生日",
                      hintStyle: TextStyle(
                        color: rgba(171, 171, 171, 1),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 18,
                    child: Image.asset(
                      "images/Arrow down@3x.png",
                      width: 12,
                      height: 7,
                    ),
                  ),
                ],
              ),
            ),
            //性别
            SizedBox(
              height: 15,
            ),
            Row(
              children: <Widget>[
                //女生
                Expanded(
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        _infoPackage["gender"] = 0;
                        this._checkInfoInput();
                      });
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.3,
                            color: _infoPackage["gender"] == 0
                                ? rgba(254, 52, 91, 1)
                                : rgba(188, 188, 188, 1),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.3,
                            color: _infoPackage["gender"] == 0
                                ? rgba(254, 52, 91, 1)
                                : rgba(188, 188, 188, 1),
                          ),
                        ),
                        hintText: "女生",
                        hintStyle: TextStyle(
                          color: _infoPackage["gender"] == 0
                              ? rgba(254, 52, 91, 1)
                              : rgba(171, 171, 171, 1),
                          fontSize: 14,
                        ),
                        prefixIcon: Container(
                          padding: EdgeInsets.fromLTRB(0, 9.5, 13, 9.5),
                          child: Image.asset(
                            "images/woman_icon@3x.png",
                            width: 18,
                            height: 25,
                            color: _infoPackage["gender"] == 0
                                ? rgba(254, 52, 91, 1)
                                : rgba(171, 171, 171, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 14.5,
                ),
                //男生
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _infoPackage["gender"] = 1;
                        this._checkInfoInput();
                      });
                    },
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.3,
                            color: _infoPackage["gender"] == 1
                                ? rgba(254, 52, 91, 1)
                                : rgba(188, 188, 188, 1),
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.3,
                            color: _infoPackage["gender"] == 1
                                ? rgba(254, 52, 91, 1)
                                : rgba(188, 188, 188, 1),
                          ),
                        ),
                        hintText: "男生",
                        hintStyle: TextStyle(
                          color: _infoPackage["gender"] == 1
                              ? rgba(254, 52, 91, 1)
                              : rgba(171, 171, 171, 1),
                          fontSize: 14,
                        ),
                        prefixIcon: Container(
                          padding: EdgeInsets.fromLTRB(0, 9.5, 13, 9.5),
                          child: Image.asset(
                            "images/man_icon@3x.png",
                            width: 18,
                            height: 25,
                            color: _infoPackage["gender"] == 1
                                ? rgba(254, 52, 91, 1)
                                : rgba(171, 171, 171, 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 9.5,
            ),
            //性别提示
            Text(
              "注册成功后，性别不可修改",
              style: TextStyle(
                color: rgba(171, 171, 171, 1),
                fontSize: 11,
              ),
            ),
            SizedBox(
              height: 26.5,
            ),
            //个性签名
            Container(
              height: 112,
              padding: EdgeInsets.fromLTRB(8.5, 6, 8.5, 3),
              decoration: BoxDecoration(
                color: rgba(245, 245, 245, 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      maxLength: _maxLength,
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "个性签名",
                        hintStyle: TextStyle(
                          color: rgba(171, 171, 171, 1),
                          fontSize: 14,
                        ),
                        counterText: "",
                      ),
                      onChanged: (text) {
                        setState(() {
                          _infoPackage["signature"] = text;
                          this._checkInfoInput();
                        });
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${_infoPackage['signature'].length}/$_maxLength",
                    style: TextStyle(
                      color: rgba(171, 171, 171, 1),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 39,
            ),
            //下一步
            Container(
              height: 44,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: _nextAviable == false ? rgba(216, 216, 216, 1) : null,
                borderRadius: BorderRadius.circular(44 / 2),
                gradient: _nextAviable == false
                    ? null
                    : LinearGradient(
                        colors: [
                          rgba(255, 44, 96, 1),
                          rgba(255, 114, 81, 1),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
              ),
              child: FlatButton(
                padding: EdgeInsets.zero,
                onPressed: _nextAviable == false
                    ? null
                    : () {
                        this._onConfirm();
                      },
                child: Text(
                  "下一步",
                  style: TextStyle(
                    fontSize: 16,
                    color: rgba(255, 255, 255, 1),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(44 / 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
