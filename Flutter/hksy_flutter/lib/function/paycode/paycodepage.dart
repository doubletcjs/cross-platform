import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/pages/personal/views/infosectioncell.dart';
import 'package:hksy_flutter/public/public.dart';

class PaycodePage extends StatefulWidget {
  bool isReset = false;
  PaycodePage({Key key, this.isReset = false}) : super(key: key);

  @override
  _PaycodePageState createState() => _PaycodePageState();
}

class _PaycodePageState extends State<PaycodePage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      this.widget.isReset = true;
    });
  }

  Widget _textField(
    String placeholder, {
    int maxLength = 6,
    bool obscureText = true,
    TextAlign textAlign = TextAlign.right,
  }) {
    return TextField(
      style: TextStyle(
        color: rgba(255, 255, 255, 1),
        fontSize: 13,
      ),
      obscureText: obscureText,
      scrollPadding: EdgeInsets.zero,
      textAlign: textAlign,
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 11.5),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: placeholder,
        hintStyle: TextStyle(
          fontSize: 13,
          color: rgba(145, 152, 173, 1),
        ),
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackgroundColor,
      appBar: customAppBar(
        title: this.widget.isReset ? "密码重设" : "密码设置",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        onTapDown: (res) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
          children: <Widget>[
            this.widget.isReset
                ? InfoSection(
                    cells: <Widget>[
                      InfoCell(
                        name: "绑定账号",
                        value: "151*****3552",
                        showArrow: false,
                      ),
                      InfoCell(
                        showLine: false,
                        leftChild: Expanded(
                          child: Container(
                            height: 22,
                            child: _textField(
                              "请输入手机验证码",
                              obscureText: false,
                              maxLength: 4,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        rightChild: Material(
                          color: rgba(28, 35, 63, 1),
                          child: InkWell(
                            child: Text(
                              "获取验证码",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: rgba(23, 96, 255, 1),
                                fontSize: 15,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  )
                : Container(),
            InfoSection(
              topSpace: this.widget.isReset ? 20 : 0,
              cells: <Widget>[
                InfoCell(
                  name: "设置密码",
                  rightChild: Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      height: 22,
                      child: _textField("请输入新的6位数支付密码"),
                    ),
                  ),
                ),
                InfoCell(
                  name: "再次确认",
                  rightChild: Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      height: 22,
                      child: _textField("再次输入新的6位数支付密码"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 49,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: rgba(23, 96, 255, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: Text(
                this.widget.isReset ? "确认修改" : "确认",
                style: TextStyle(
                  fontSize: 15,
                  color: rgba(255, 255, 255, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
