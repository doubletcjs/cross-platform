import 'package:flutter/material.dart';
import 'package:ideaclass/public/public.dart';

class FeedBackPage extends StatelessWidget {
  const FeedBackPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _editingController = TextEditingController();
    int _commentLenght = 150;
    void _submitAction() {
      if (isStringEmpty(_editingController.text)) {
        showToast("至少说点啥～", context);
        return;
      }

      FocusScope.of(context).requestFocus(FocusNode());
    }

    return Scaffold(
      appBar: customAppBar(title: "意见反馈"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: rgba(0, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                height: 186,
                child: TextField(
                  maxLength: _commentLenght,
                  controller: _editingController,
                  scrollPadding: EdgeInsets.zero,
                  maxLines: 10,
                  style: TextStyle(
                    fontSize: 14,
                    color: rgba(23, 23, 23, 1),
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                    hintText: "和我们的工作人员反馈一下您的意见吧",
                    hintStyle: TextStyle(
                      fontSize: 15,
                      color: rgba(136, 136, 136, 1),
                    ),
                    border: InputBorder.none,
                  ),
                ),
                decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12, 44, 12, 0),
                height: 49, 
                child: FlatButton(
                  onPressed: () {
                    _submitAction();
                  },
                  child: Text(
                    "提交",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                  color: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
