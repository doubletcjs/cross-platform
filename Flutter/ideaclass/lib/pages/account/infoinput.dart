import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/public/public.dart';

class InfoInputPage extends StatefulWidget {
  String title;
  InfoInputPage({this.title = ""});

  @override
  _InfoInputPageState createState() => _InfoInputPageState();
}

class _InfoInputPageState extends State<InfoInputPage> {
  TextEditingController _editingController = TextEditingController();
  Map _account = {};

  void _refreshAccount(user) {
    _account = user;
    if (this.widget.title == "真实姓名") {
      _editingController.text = _account["trueName"];
    } else if (this.widget.title == "昵称") {
      _editingController.text = _account["nickname"];
    } else if (this.widget.title == "学校名称") {
      _editingController.text = _account["school"];
    }
  }

  void _saveFunctionAction() {
    Map<String, Object> parameters = {};
    if (this.widget.title == "真实姓名") {
      if (_editingController.text != _account["trueName"]) {
        parameters["trueName"] = _editingController.text;
      }
    } else if (this.widget.title == "昵称") {
      if (_editingController.text != _account["nickname"]) {
        parameters["nickname"] = _editingController.text;
      }
    } else if (this.widget.title == "学校名称") {
      if (_editingController.text != _account["school"]) {
        parameters["school"] = _editingController.text;
      }
    }

    if (parameters.length > 0) {
      showHUD();
      AccountApi().editUserInfo(
        parameters,
        (data, msg) {
          if (data != null) {
            if (this.widget.title == "真实姓名") {
              _account["trueName"] = _editingController.text;
            } else if (this.widget.title == "昵称") {
              _account["nickname"] = _editingController.text;
            } else if (this.widget.title == "学校名称") {
              _account["school"] = _editingController.text;
            }

            recordUserInfo(_account);
            setState(
              () {
                Future.delayed(
                  Duration(milliseconds: 600),
                  () {
                    hideHUD();
                    Navigator.of(context).pop();
                  },
                );
              }
            );
          } else {
            hideHUD();
            showToast(msg, context);
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();

    AccountApi().loadLocalAccount(
      (user) {
        setState(
          () {
            this._refreshAccount(user);
          }
        );
      },
    );
  }

  @override
  void didUpdateWidget(InfoInputPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    AccountApi().loadLocalAccount(
      (user) {
        setState(
          () {
            this._refreshAccount(user);
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: this.widget.title),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 37,
              margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
              child: AccountApi().functionTextField(
                  placeholder: "请输入${this.widget.title}",
                  padding: EdgeInsets.zero,
                  controller: _editingController),
            ),
            SizedBox(
              height: 25,
            ),
            buttonWidget(
              Container(
                height: 49,
                alignment: Alignment.center,
                child: Text(
                  "完成",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              context,
              onTap: () {
                this._saveFunctionAction();
              },
              color: kMainColor,
              radius: BorderRadius.circular(8),
            ),
          ],
        ),
      ),
    );
  }
}
