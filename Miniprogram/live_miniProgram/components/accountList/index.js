//Component Object
Component({
  properties: {
    accountList: {
      type: Array,
      value: []
    },

  },
  data: {

  },
  methods: {
    // 关注
    attention: function (e) {
      let index = e.currentTarget.dataset.index;
      let attention = !this.data.accountList[index].attention;
      let state = {
        index: index,
        attention: attention
      }
      this.triggerEvent('accountAttentionChange', state)

      // console.log(e, index, state)
    }
  },
  created: function () {

  },
  attached: function () {

  },
  ready: function () {

  },
  moved: function () {

  },
  detached: function () {

  }
});