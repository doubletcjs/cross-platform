import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/public/public.dart';
// import 'package:image_pickers/UIConfig.dart';
// import 'package:image_pickers/image_pickers.dart';

typedef kCertificationBlock = void Function(Map object);

class CertificationBase extends StatefulWidget {
  kCertificationBlock inputHandle;
  CertificationBase({Key key, this.inputHandle}) : super(key: key);

  @override
  _CertificationBaseState createState() => _CertificationBaseState();
}

class _CertificationBaseState extends State<CertificationBase> {
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _idcardEditingController = TextEditingController();

  String _frontImagePath = "";
  String _reverseImagePath = "";

  void _handlInfo() {
    if (this.widget.inputHandle != null) {
      this.widget.inputHandle({
        "reverse": _reverseImagePath,
        "front": _frontImagePath,
        "name": _nameEditingController.text,
        "idcard": _idcardEditingController.text,
      });
    }
  }

  void _selectImage(bool reverse) {
    // ImagePickers.pickerPaths(
    //   selectCount: 1,
    //   showCamera: true,
    //   uiConfig: UIConfig(
    //     uiThemeColor: Colors.black,
    //   ),
    // ).then((List medias) {
    //   if (medias.length > 0) {
    //     var path = medias.first.path;
    //     setState(() {
    //       if (reverse) {
    //         _reverseImagePath = path;
    //       } else {
    //         _frontImagePath = path;
    //       }

    //       this._handlInfo();
    //     });
    //   }
    // });
  }

  Widget _buttonImage(String imagePath, bool reverse) {
    return Container(
      width: 259,
      height: 138.5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: rgba(21, 25, 54, 1),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Stack(
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.5),
            ),
            onPressed: () {
              if (imagePath.length == 0) {
                this._selectImage(reverse);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7.5),
              child: imagePath.length == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "images/addImg@3x.png",
                          width: 27,
                          fit: BoxFit.fitWidth,
                        ),
                        SizedBox(
                          height: 11.5,
                        ),
                        Text(
                          "点击上传",
                          style: TextStyle(
                            color: rgba(255, 255, 255, 1),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    )
                  : Image.file(
                      File(imagePath),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Positioned(
            top: -7,
            right: -7,
            child: imagePath.length == 0
                ? Container()
                : IconButton(
                    icon: Image.asset(
                      "images/ico_del@3x.png",
                      width: 20,
                      height: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        if (reverse) {
                          _reverseImagePath = "";
                        } else {
                          _frontImagePath = "";
                        }

                        this._handlInfo();
                      });
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView(
        padding: EdgeInsets.fromLTRB(12, 12, 12, 60),
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 20.5, 10.5, 0),
            decoration: BoxDecoration(
              color: rgba(28, 35, 63, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "填写身份信息",
                    style: TextStyle(
                      fontSize: 18,
                      color: rgba(255, 255, 255, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.5,
                ),
                Container(
                  height: 60.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "姓名：",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _nameEditingController,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "请输入真实的姓名",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                          onChanged: (text) {
                            this._handlInfo();
                          },
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: rgba(145, 152, 173, 0.2),
                        width: 0.5,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 60.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "证件号码：",
                        style: TextStyle(
                          fontSize: 15,
                          color: rgba(255, 255, 255, 1),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _idcardEditingController,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 15,
                            color: rgba(255, 255, 255, 1),
                          ),
                          decoration: InputDecoration(
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "请输入身份证件号码",
                            hintStyle: TextStyle(
                              fontSize: 15,
                              color: rgba(145, 152, 173, 1),
                            ),
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(18),
                          ],
                          onChanged: (text) {
                            this._handlInfo();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 20.5, 10.5, 0),
            decoration: BoxDecoration(
              color: rgba(28, 35, 63, 1),
              borderRadius: BorderRadius.circular(7.5),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "拍照上传您的二代身份证",
                    style: TextStyle(
                      fontSize: 18,
                      color: rgba(255, 255, 255, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.5,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "上传证件正面",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                ),
                _buttonImage(_frontImagePath, false),
                SizedBox(
                  height: 60,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "上传证件反面",
                    style: TextStyle(
                      fontSize: 15,
                      color: rgba(255, 255, 255, 1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.5,
                ),
                _buttonImage(_reverseImagePath, true),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
