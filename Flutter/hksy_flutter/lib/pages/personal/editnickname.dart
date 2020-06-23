import 'package:dart_notification_center/dart_notification_center.dart';
import 'package:flutter/material.dart';
import 'package:hksy_flutter/function/account/api/accountapi.dart';
import 'package:hksy_flutter/public/public.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class EditNickName extends StatefulWidget {
  EditNickName({Key key}) : super(key: key);

  @override
  _EditNickNameState createState() => _EditNickNameState();
}

class _EditNickNameState extends State<EditNickName> {
  TextEditingController _editingController = TextEditingController();

  @override
  void didUpdateWidget(EditNickName oldWidget) {
    super.didUpdateWidget(oldWidget);

    setState(() {
      _editingController.text = "${currentAcctount["nickname"]}";
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _editingController.text = "${currentAcctount["nickname"]}";
    });
  }

  void _onConfirm() {
    if (isStringEmpty(_editingController.text)) {
      showToast("请输入昵称", context);
      return;
    }

    if (_editingController.text == "${currentAcctount["nickname"]}") {
      showToast("昵称没有发生变化哦!", context);
      return;
    }

    XsProgressHud hud = initHUD(context);
    AccountApi.changeAvater(_editingController.text, "", (data, msg) {
      hideHUD(hud);
      if (data != null) {
        showToast("修改昵称成功！", context);
        DartNotificationCenter.post(channel: kRefreshAccountNotification);

        Future.delayed(Duration(milliseconds: 500), () {
          Navigator.of(context).pop();
        }); //
      } else {
        showToast(msg, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: "修改昵称",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: kMainBackgroundColor,
          padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "新昵称",
                style: TextStyle(
                  fontSize: 18,
                  color: rgba(255, 255, 255, 1),
                ),
              ),
              SizedBox(
                height: 5.5,
              ),
              Container(
                height: 50,
                child: TextField(
                  style: TextStyle(
                    color: rgba(255, 255, 255, 1),
                    fontSize: 13,
                  ),
                  controller: _editingController,
                  decoration: InputDecoration(
                    hintText: "请输入新昵称",
                    hintStyle: TextStyle(
                      color: rgba(145, 152, 173, 1),
                      fontSize: 13,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: rgba(145, 152, 173, 0.2),
                      ),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: rgba(145, 152, 173, 0.2),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 0.5,
                        color: rgba(145, 152, 173, 0.2),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 88,
              ),
              Container(
                height: 49,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: rgba(23, 96, 255, 1),
                  borderRadius: BorderRadius.circular(7.5),
                ),
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    this._onConfirm();
                  },
                  child: Text(
                    "确认",
                    style: TextStyle(
                      color: rgba(255, 255, 255, 1),
                      fontSize: 15,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
