import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ideaclass/pages/commons/searchtablist.dart';
import 'package:ideaclass/public/public.dart';

class SearchCenterPage extends StatefulWidget {
  List hotSearch;
  List searchBanner;
  int searchType = 0; // 0 课程 1 活动

  SearchCenterPage({this.hotSearch, this.searchBanner, this.searchType = 0});

  @override
  _SearchCenterPageState createState() => _SearchCenterPageState();
}

class _SearchCenterPageState extends State<SearchCenterPage> {
  TextEditingController _editingController = TextEditingController();
  List _history = [];

  void _hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _emptyHistory() {}

  Widget _hotSearchCell({bool isHistory = false}) {
    return (this.widget.hotSearch == null || this.widget.hotSearch.length == 0)
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 2, 0, 8),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      isHistory == true ? "历史搜索" : "热门搜索",
                      style: TextStyle(
                        fontSize: 14,
                        color: rgba(23, 23, 23, 1),
                      ),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    isHistory == true
                        ? buttonWidget(
                            Image.asset(
                              "images/icon_search_delete@3x.png",
                              width: 14,
                              height: 14,
                            ),
                            context,
                            onTap: () {
                              this._emptyHistory();
                            },
                          )
                        : Container(),
                    SizedBox(
                      width: 12,
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 12,
                runSpacing: 2,
                children:
                    (isHistory == true ? _history : this.widget.hotSearch).map(
                  (search) {
                    return FlatButton(
                      color: rgba(236, 236, 236, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                      child: Text(
                        search,
                        style: TextStyle(
                          fontSize: 13,
                          color: rgba(136, 136, 136, 1),
                        ),
                      ),
                      onPressed: () {
                        this._functionSeach(search);
                      },
                    );
                  },
                ).toList(),
              )
            ],
          );
  }

  Widget _bannerSwiper() {
    return (this.widget.searchBanner == null ||
            this.widget.searchBanner.length == 0)
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
            height: 89,
            child: Swiper(
              itemCount: this.widget.searchBanner.length,
              autoplay: this.widget.searchBanner.length <= 1 ? false : true,
              itemBuilder: (context, index) {
                return ClipRRect(
                  child: Image.network(
                    this.widget.searchBanner[index]["picUrl"],
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(8),
                );
              },
            ),
          );
  }

  void _functionSeach(String keyword) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SearchTabList(
            keyword: keyword,
            searchType: this.widget.searchType,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: searchNavigationBar(
          context,
          placeholder: "在这里搜索你想要的" +
              (this.widget.searchType == 0
                  ? "课程"
                  : this.widget.searchType == 1 ? "活动" : "内容"),
          controller: _editingController,
          onSubmitted: (text) {
            this._functionSeach(text);
            this._hideKeyboard();
          },
        ),
        body: ListView.builder(
          padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
          itemBuilder: (context, index) {
            return index == 0
                ? _hotSearchCell()
                : index == 1
                    ? _bannerSwiper()
                    : (index == 2 && _history.length > 0)
                        ? _hotSearchCell(isHistory: true)
                        : Container();
          },
          itemCount: 3,
        ),
      ),
      onTap: () {
        this._hideKeyboard();
      },
    );
  }
}
