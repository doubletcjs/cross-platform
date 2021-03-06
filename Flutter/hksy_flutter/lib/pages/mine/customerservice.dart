import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hksy_flutter/pages/mine/api/mineapi.dart';
import 'package:hksy_flutter/public/public.dart';

class CustomerService extends StatefulWidget {
  CustomerService({Key key}) : super(key: key);

  @override
  _CustomerServiceState createState() => _CustomerServiceState();
}

class _CustomerServiceState extends State<CustomerService> {
  TextEditingController _contentController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Widget _textView(String placeholder, TextEditingController controller) {
    return Container(
      height: 124,
      padding: EdgeInsets.fromLTRB(11, 0, 11, 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: rgba(145, 152, 173, 0.2),
        ),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: TextField(
        style: TextStyle(
          color: rgba(255, 255, 255, 1),
          fontSize: 13,
        ),
        scrollPadding: EdgeInsets.zero,
        maxLines: null,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 14),
          hintText: placeholder,
          hintStyle: TextStyle(
            color: rgba(145, 152, 173, 1),
            fontSize: 13,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          filled: true,
        ),
      ),
    );
  }

  Widget _textField(
    String text,
    String placeholder,
    TextEditingController controller, {
    List<TextInputFormatter> inputFormatters,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 40,
      padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: rgba(145, 152, 173, 0.2),
        ),
        borderRadius: BorderRadius.circular(7.5),
      ),
      child: Row(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              color: rgba(255, 255, 255, 1),
              fontSize: 13,
            ),
          ),
          SizedBox(
            width: 3,
          ),
          Expanded(
            child: TextField(
              style: TextStyle(
                color: rgba(255, 255, 255, 1),
                fontSize: 13,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(0, -12, 0, 0),
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: rgba(145, 152, 173, 1),
                  fontSize: 13,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              inputFormatters: inputFormatters != null ? inputFormatters : [],
              keyboardType: keyboardType,
            ),
          ),
        ],
      ),
    );
  }

  void _onConfirm() {
    if (isStringEmpty(_contentController.text)) {
      showToast("请输入您的留言内容", context);
      return;
    }

    if (isStringEmpty(_contentController.text)) {
      showToast("请输入您的姓名", context);
      return;
    }

    if (regularMatch(_phoneController.text, kPhoneRegExp) == false) {
      showToast("请输入正确的手机号", context);
      return;
    }

    MineApi.addMessage(currentAcctount["userId"], _nameController.text,
        _phoneController.text, _contentController.text, (data, msg) {
      if (data != null) {
        Navigator.of(context).pop();
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
        title: "在线客服",
        brightness: Brightness.dark,
        backgroundColor: kMainBackgroundColor,
        color: Colors.white,
      ),
      body: GestureDetector(
        child: ListView(
          padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
          children: <Widget>[
            Text(
              "您好，现在客服不在线，请留言。如果没有留下您的联系方式，客服将无法和您联系！",
              style: TextStyle(
                color: rgba(255, 255, 255, 1),
                fontSize: 13,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _textView("请输入您的留言", _contentController),
            SizedBox(
              height: 28,
            ),
            Text(
              "留下以下信息，方便与您及时联系",
              style: TextStyle(
                color: rgba(255, 255, 255, 1),
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _textField("姓名：", "请输入您的姓名", _nameController),
            SizedBox(
              height: 15,
            ),
            _textField(
              "手机：",
              "请输入您的手机号码",
              _phoneController,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 49,
              decoration: BoxDecoration(
                color: rgba(23, 96, 255, 1),
                borderRadius: BorderRadius.circular(7.5),
              ),
              child: FlatButton(
                onPressed: () {
                  this._onConfirm();
                },
                child: Text(
                  "提交留言",
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
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
        onTapDown: (res) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
      ),
    );
  }
}
