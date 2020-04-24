import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:ideaclass/pages/account/membercenter.dart';
import 'package:ideaclass/pages/commons/scancenter.dart';
import 'package:ideaclass/pages/commons/searchcenter.dart';
import 'package:ideaclass/public/public.dart';

List _hotSearch = [];
List _searchBanner = [];

class HomeHeader extends StatefulWidget {
  Map homeData;
  HomeHeader({this.homeData});

  _HomeHeaderState _state;
  @override
  State<StatefulWidget> createState() {
    _state = _HomeHeaderState();

    return _state;
  }
}

class _HomeHeaderState extends State<HomeHeader> {
  _HomeHeaderSwiper _swiper = _HomeHeaderSwiper();
  _HomeHeaderClassifyPage _classify = _HomeHeaderClassifyPage();
  _HomeHeaderAdvert _advert = _HomeHeaderAdvert();

  void _loadData() {
    List banners = this.widget.homeData["bannerList"] == null
        ? []
        : this.widget.homeData["bannerList"];
    List adverts = this.widget.homeData["advertList"] == null
        ? []
        : this.widget.homeData["advertList"];
    List classifies = this.widget.homeData["courseList"] == null
        ? []
        : this.widget.homeData["courseList"];
    _hotSearch = this.widget.homeData["hostSearch"] == null
        ? []
        : this.widget.homeData["hostSearch"];
    _searchBanner = this.widget.homeData["searchBannerList"] == null
        ? []
        : this.widget.homeData["searchBannerList"];

    _swiper.reloadData(banners);
    _classify.reloadData(classifies);
    _advert.reloadData(adverts);
  }

  @override
  void initState() {
    super.initState();
    this._loadData();
  }

  @override
  void didUpdateWidget(HomeHeader oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _swiper,
            Positioned(
              left: 0,
              top: MediaQuery.of(context).padding.top,
              right: 0,
              child: _HomeHeaderMenuSearch(),
            ),
          ],
        ),
        _classify,
        _advert,
      ],
    );
  }
}

class _HomeHeaderMenuSearch extends StatelessWidget {
  void goMemberCenter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return MemberCenterPage();
        },
      ),
    );
  }

  void goScanCenter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ScanCenterPage();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      height: 44,
      child: Row(
        children: <Widget>[
          Expanded(
            child: _BaseSearchBar(),
          ),
          SizedBox(
            width: 14,
          ),
          buttonWidget(
            Image.asset(
              "images/shouye-huiyuan@3x.png",
              width: 23,
              height: 18,
            ),
            context,
            onTap: () {
              this.goMemberCenter(context);
            },
          ),
          SizedBox(
            width: 14,
          ),
          buttonWidget(
            Image.asset(
              "images/nav-saoyisao@3x.png",
              width: 18,
              height: 18,
            ),
            context,
            onTap: () {
              this.goScanCenter(context);
            },
          ),
        ],
      ),
    );
  }
}

class _BaseSearchBar extends StatelessWidget {
  void goSearchCenter(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SearchCenterPage(
            hotSearch: _hotSearch,
            searchBanner: _searchBanner,
            searchType: 0,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buttonWidget(
      Container(
        height: 31,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/nav@3x.png",
              width: 15,
              height: 15,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              "在这里搜索你想要的课程",
              style: TextStyle(
                color: rgba(110, 110, 110, 0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: rgba(255, 255, 255, 0.5),
          borderRadius: BorderRadius.circular(31 / 2),
        ),
      ),
      context,
      onTap: () {
        this.goSearchCenter(context);
      },
      radius: BorderRadius.circular(31 / 2),
    );
  }
}

class _HomeHeaderAdvert extends StatelessWidget {
  List _listData = [];

  void reloadData(List list) {
    if (list != null) {
      _listData = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _listData.length == 0
        ? Container()
        : Container(
            padding: EdgeInsets.fromLTRB(0, 11, 0, 11),
            height: 75,
            color: rgba(250, 250, 250, 1),
            child: Swiper(
              itemCount: _listData.length,
              autoplay: _listData.length <= 1 ? false : true,
              itemBuilder: (context, index) {
                return Image.network(
                  _listData[index]["picUrl"],
                  fit: BoxFit.fill,
                );
              },
            ),
          );
  }
}

class _HomeHeaderSwiper extends StatelessWidget {
  List _listData = [];

  void reloadData(List list) {
    if (list != null) {
      _listData = list;
    }
  }

  void bannerItemSelect(index, BuildContext context) {
    kLog("bannerItemSelect:$index");
  }

  @override
  Widget build(BuildContext context) {
    return _listData.length == 0
        ? Container(
            height: 185 + MediaQuery.of(context).padding.top,
            child: ClipRRect(
              child: Image.asset(
                "images/placeholder@3x.png",
                fit: BoxFit.cover,
              ),
            ),
          )
        : Container(
            height: 185 + MediaQuery.of(context).padding.top,
            child: Swiper(
              itemCount: _listData.length,
              autoplay: _listData.length == 1 ? false : true,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  size: 6,
                  activeSize: 6,
                  color: Colors.white38,
                  activeColor: Colors.white,
                  space: 4,
                ),
              ),
              itemBuilder: (context, index) {
                String url = "";
                if (_listData.length > 0 && _listData[index] != null) {
                  url = "${_listData[index]["picUrl"]}";
                }

                return buttonWidget(
                  Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                  context,
                  onTap: () {
                    this.bannerItemSelect(index, context);
                  },
                );
                // );
              },
            ),
          );
  }
}

class _HomeHeaderClassifyPage extends StatelessWidget {
  List _listData = [];

  void reloadData(List list) {
    if (list != null) {
      _listData = list;
    }
  }

  Widget _classifyWidget(item, BuildContext context) {
    return buttonWidget(
      Container(
        width: 59,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 4,
            ),
            Container(
              child: Image.network(
                item["image"],
                width: 47,
                height: 47,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(47 / 2),
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              item["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: rgba(23, 23, 23, 1),
              ),
            ),
          ],
        ),
      ),
      context,
      onTap: () {
        kLog("id:${item["classId"]}");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _listData.length == 0
        ? Container(height: 71, color: Colors.white)
        : Container(
            padding: EdgeInsets.fromLTRB(0, 13, 0, 10),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing:
                  (MediaQuery.of(context).size.width - 59 * 5 - 24 * 2) / 4,
              runSpacing: 8,
              children: _listData.map(
                (item) {
                  return _classifyWidget(item, context);
                },
              ).toList(),
            ),
          );
  }
}
