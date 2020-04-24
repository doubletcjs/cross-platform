import 'package:flutter/material.dart';
import 'package:ideaclass/pages/account/api/accountapi.dart';
import 'package:ideaclass/pages/commons/api/commonapi.dart';
import 'package:ideaclass/public/public.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef kEducationListBlock = void Function(String gradeId, String gradeName);

class EducationListPage extends StatefulWidget {
  kEducationListBlock educationHandle;
  EducationListPage({this.educationHandle});

  @override
  _EducationListPageState createState() => _EducationListPageState();
}

class _EducationListPageState extends State<EducationListPage> {
  List _dataList = [];
  Map _account = {};

  void _refreshData() {
    CommonApi().getEduList(
      (data, msg) {
        if (data != null) {
          _dataList = data;
        } else {
          showToast(msg, context);
        }

        setState(
          () {
            _refreshController.refreshCompleted();
          },
        );
      },
    );
  }

  void _selectEducation(index) {
    var gradeName = _dataList[index]["name"];
    if (gradeName != _account["gradeName"]) {
      var gradeId = _dataList[index]["classId"];
      showHUD();
      AccountApi().editUserInfo(
        {
          "gradeId": gradeId,
        },
        (data, msg) {
          if (data != null) {
            _account["gradeName"] = gradeName;
            _account["gradeId"] = gradeId;
            recordUserInfo(_account);
            setState(
              () {
                if (this.widget.educationHandle != null) {
                  this.widget.educationHandle("$gradeId", "$gradeName");
                }

                hideHUD();
                Future.delayed(
                  Duration(milliseconds: 600),
                  () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
          } else {
            hideHUD();
            showToast(msg, context);
          }
        },
      );
    }
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  @override
  void initState() {
    super.initState();

    AccountApi().loadLocalAccount(
      (user) {
        setState(
          () {
            _account = user;
          },
        );
      },
    );
  }

  @override
  void didUpdateWidget(EducationListPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    Future.delayed(
      Duration(milliseconds: 100),
      () {
        if (_dataList.length == 0) {
          _refreshController.requestRefresh();
        }
      },
    );

    AccountApi().loadLocalAccount(
      (user) {
        setState(
          () {
            _account = user;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "选择年级",
      ),
      body: functionRefresher(
        _refreshController,
        ListView.separated(
          itemBuilder: (context, index) {
            return buttonWidget(
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      _dataList[index]["name"],
                      style: TextStyle(
                        fontSize: 15,
                        color: rgba(51, 51, 51, 1),
                      ),
                    ),
                    _account["gradeName"] == _dataList[index]["name"]
                        ? Icon(Icons.check)
                        : Container(),
                  ],
                ),
              ),
              context,
              onTap: () {
                this._selectEducation(index);
              },
              color: Colors.white,
            );
          },
          separatorBuilder: (context, index) {
            return Container(
              height: 10,
              color: rgba(249, 249, 249, 1),
            );
          },
          itemCount: _dataList.length,
        ),
        enableLoadMore: false,
        onRefresh: () {
          this._refreshData();
        },
      ),
    );
  }
}
