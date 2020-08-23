import 'package:corner_app/pages/home/create_base.dart';
import 'package:corner_app/pages/home/views/home_cell.dart';
import 'package:corner_app/pages/home/views/home_wrap.dart';
import 'package:flutter/material.dart';
import 'package:corner_app/public/public.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  //创建
  void _createAction() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CreateBase();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rgba(255, 255, 255, 1),
      appBar: customAppBar(
        titleView: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          height: AppBar().preferredSize.height,
          child: Row(
            children: [
              Text(
                "街角",
                style: TextStyle(
                  fontSize: 20,
                  color: rgba(51, 51, 51, 1),
                ),
              ),
              SizedBox(
                width: 18.5,
              ),
              // 搜索
              Expanded(
                child: Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: rgba(247, 246, 245, 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: FlatButton(
                    onPressed: () {},
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Image.asset(
                          "images/home_tab_search_icon@3x.png",
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "搜索用户、角落或是内容",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: rgba(153, 153, 153, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.5,
              ),
              // 创建
              InkWell(
                onTap: () {
                  this._createAction();
                },
                child: Image.asset(
                  "images/home_tab_add@3x.png",
                  width: 28,
                  height: 28,
                ),
                borderRadius: BorderRadius.circular(28 / 2),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(0, 22, 0, 0),
        children: [
          HomeWrap(
            dataList: [],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(
              "精选推荐",
              style: TextStyle(
                color: rgba(50, 50, 50, 1),
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Column(
            children: [
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
              HomeCell(),
            ],
          )
        ],
      ),
    );
  }
}
