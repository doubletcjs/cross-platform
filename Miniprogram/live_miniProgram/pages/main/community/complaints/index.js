//Page Object
Page({
  data: {
    violations: [{
        name: "涉黄信息",
        selected: false,
      },
      {
        name: "政治敏感",
        selected: false,
      },
      {
        name: "违法犯罪",
        selected: false,
      },
      {
        name: "涉嫌诈骗",
        selected: false,
      },
      {
        name: "造谣传谣",
        selected: false,
      },
      {
        name: "垃圾广告",
        selected: false,
      }
    ],
    infringements: [{
        name: "人身攻击",
        selected: false,
      },
      {
        name: "泄露秘密",
        selected: false,
      },
      {
        name: "骚扰",
        selected: false,
      }
    ],
    didComplaint: false
  },
  //options(Object)
  onLoad: function (options) {

  },
  onReady: function () {

  },
  onShow: function () {

  },
  onHide: function () {

  },
  onUnload: function () {

  },
  onPullDownRefresh: function () {

  },
  onReachBottom: function () {

  },
  onShareAppMessage: function () {

  },
  onPageScroll: function () {

  },
  //item(index,pagePath,text)
  onTabItemTap: function (item) {

  },
  //内容违规
  violationTap: function (res) {
    var index = res.currentTarget.dataset.index
    var violations = this.data.violations
    var item = violations[index]

    if (item["selected"] == true) {
      item["selected"] = false
    } else {
      if (this.allSelectedCount() < 3) {
        item["selected"] = true
      }
    }

    violations[index] = item
    this.setData({
      violations: violations
    })
  },
  //侵权利益
  infringementTap: function (res) {
    var index = res.currentTarget.dataset.index
    var infringements = this.data.infringements
    var item = infringements[index]

    if (item["selected"] == true) {
      item["selected"] = false
    } else {
      if (this.allSelectedCount() < 3) {
        item["selected"] = true
      }
    }

    infringements[index] = item
    this.setData({
      infringements: infringements
    })
  },
  //已选择数
  allSelectedCount() {
    var count = 0;
    for (const item of this.data.violations) {
      if (item["selected"] == true) {
        count += 1
      }
    }

    for (const item of this.data.infringements) {
      if (item["selected"] == true) {
        count += 1
      }
    }

    return count;
  },
  //提交投诉
  submitComplaint() {
    if (this.allSelectedCount() > 1) {
      this.setData({
        didComplaint: !this.data.didComplaint
      })
    }
  }
});