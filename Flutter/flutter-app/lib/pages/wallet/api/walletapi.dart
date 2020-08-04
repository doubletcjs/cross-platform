import '../../../public/networking.dart';

class WalletApi {
  // 账单记录
  /* 
  page integer 分页
  per_page integer 每页记录条数 默认15
  */
  static consumptionList(page, perpage, finish) {
    Networking.requestBase("/api/v1/consumption/lists", finish,
        method: "GET",
        params: {
          "page": page,
          "per_page": perpage,
        });
  }

  // 苹果支付商品id列表
  /* 
  type integer 类型 1 会员 2 充值币 不传默认为1
  */
  static applePayList(type, finish) {
    Networking.requestBase("/api/v1/applePay/list", finish,
        method: "GET",
        params: {
          "type": type,
        });
  }
}
