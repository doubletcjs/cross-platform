//Component Object
Component({
  properties: {

  },
  data: {

  },
  methods: {
    //人脸识别
    nextAction() {
      this.triggerEvent("confirm", {
        face: true
      })
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

  },
});