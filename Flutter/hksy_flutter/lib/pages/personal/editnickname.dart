import 'package:flutter/material.dart';
import 'package:hksy_flutter/public/public.dart';

class EditNickName extends StatelessWidget {
  EditNickName({Key key}) : super(key: key);

  TextEditingController _editingController = TextEditingController();

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
                  onPressed: () {},
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
