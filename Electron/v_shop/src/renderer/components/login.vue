<template>
  <div id="app" class="login-container">
    <div class="login-box">
      <div class="avatar-box">
        <img src="../assets/login_logo.png" class="avatar-image" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "login"
};
</script>

<style scoped>
.login-container {
  background-color: steelblue;
}

.login-box {
  width: 450px;
  height: 300px;
  background-color: #ffffff;
  border-radius: 3px;

  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.avatar-box {
  width: 120px;
  height: 120px;

  padding: 8px;
  border-radius: 50%;
  border: solid 1px #eeeeee;
  background-color: #ffffff;
  box-shadow: 0 0 10px #eeeeee;

  position: absolute;
  left: 50%; 
  transform: translate(-50%, -50%);
}

.avatar-image {
  width: 100%;
  height: 100%;

  border-radius: 50%;
  background-color: #eeeeee;
}
</style>