import 'package:flutter/material.dart';
import 'package:repayment_flutter/public/public.dart';

typedef kBankSelectionBlock = void Function(String name, String icon);

class BankSelectionPage extends StatefulWidget {
  kBankSelectionBlock selectionHandle;

  BankSelectionPage({Key key, this.selectionHandle}) : super(key: key);

  @override
  _BankSelectionPageState createState() => _BankSelectionPageState();
}

class _BankSelectionPageState extends State<BankSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: "账单选择",
        backgroundColor: kMainColor,
        color: Colors.white,
        brightness: Brightness.dark,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(12, 16, 12, 8),
                color: Colors.white,
                child: Container(
                  decoration: BoxDecoration(
                    color: rgba(242, 242, 242, 1),
                    borderRadius: BorderRadius.circular(36 / 2),
                  ),
                  height: 36,
                  child: TextField(
                    decoration: InputDecoration(
                      hasFloatingPlaceholder: false,
                      hintText: "请输入账单名称查询",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                      prefixIcon: Container(
                        padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Icon(
                          Icons.search,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return index == 0
                        ? HotBankCell(
                            banks: [
                              {
                                "name": "自定义",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "房贷",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "车贷",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "中国银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "招商银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "上海银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "中信银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "建设银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "浙商银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "邮储银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                            ],
                            selectionHandle: (bankName, bankIcon) {
                              if (this.widget.selectionHandle != null) {
                                this.widget.selectionHandle(bankName, bankIcon);
                              }

                              Future.delayed(Duration(milliseconds: 400), () {
                                Navigator.of(context).pop();
                              });
                            },
                          )
                        : BankListCell(
                            index: "B",
                            banks: [
                              {
                                "name": "北京银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                              {
                                "name": "邮储银行",
                                "icon": "images/icon_loan_customise.png",
                              },
                            ],
                            selectionHandle: (bankName, bankIcon) {
                              if (this.widget.selectionHandle != null) {
                                this.widget.selectionHandle(bankName, bankIcon);
                              }

                              Future.delayed(Duration(milliseconds: 400), () {
                                Navigator.of(context).pop();
                              });
                            },
                          );
                  },
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BankListCell extends StatelessWidget {
  kBankSelectionBlock selectionHandle;
  String index;
  List<Map<String, String>> banks = [];

  BankListCell({Key key, this.banks, this.index = "", this.selectionHandle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (banks == null || banks.length == 0)
        ? Container()
        : Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                color: Colors.white,
                child: Text(
                  "$index",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                color: Colors.white,
                child: Column(
                  children: banks.map(
                    (bank) {
                      return buttonWidget(
                        Column(
                          children: <Widget>[
                            SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  bank["icon"],
                                  width: 34,
                                  height: 34,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "${bank["name"]}",
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Divider(
                              height: 1,
                              color: rgba(224, 224, 224, 1),
                            ),
                          ],
                        ),
                        context,
                        onTap: () {
                          if (selectionHandle != null) {
                            selectionHandle(bank["name"], bank["icon"]);
                          }
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          );
  }
}

class HotBankCell extends StatelessWidget {
  kBankSelectionBlock selectionHandle;
  List<Map<String, String>> banks = [];
  HotBankCell({Key key, this.banks, this.selectionHandle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (banks == null || banks.length == 0)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
                color: Colors.white,
                child: Text(
                  "热门账单",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                child: Wrap(
                  children: banks.map(
                    (bank) {
                      return buttonWidget(
                        Container(
                          width: (MediaQuery.of(context).size.width - 24) / 5,
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                bank["icon"],
                                width: 44,
                                height: 44,
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                "${bank["name"]}",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        context,
                        onTap: () {
                          if (selectionHandle != null) {
                            selectionHandle(bank["name"], bank["icon"]);
                          }
                        },
                        color: Colors.white,
                      );
                    },
                  ).toList(), //要显示的子控件集合
                ),
              ),
            ],
          );
  }
}
