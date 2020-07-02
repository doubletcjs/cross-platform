<template>
  <div class="alert alert-warning alert-dismissible" role="alert">
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
    <strong>{{alertTitle}}</strong>
    {{alertContent}}
  </div>
</template>

<script>
export default {
  name: "alert",
  data() {
    return {};
  },
  props: {
    alertTitle: {
      type: String,
      default: "Warning!"
    },
    alertContent: {
      type: String,
      default: " Better check yourself, you're not looking too good."
    }
  }
};
</script>

<style>
</style>