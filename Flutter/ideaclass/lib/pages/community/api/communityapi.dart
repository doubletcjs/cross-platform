import 'package:ideaclass/public/networking.dart';

class CommunityApi {
  getCommunityShareList(currPage, pageSize, Function finish) {
    Networking.requestBase(
      "/app/community/getCommunityShareList",
      finish,
      params: {"currPage": currPage, "pageSize": pageSize},
    );
  }

  getInterestingRecommend(Function finish) {
    Networking.requestBase(
      "/app/community/getInterestingRecommend",
      finish,
    );
  }
}
