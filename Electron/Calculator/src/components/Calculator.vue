<template>
  <div class="calculator">
    <div class="display">{{current ? current : 0}}</div>
    <div @click="clear" class="btn">{{current != "" ? 'C' : 'AC'}}</div>
    <div @click="sign" class="btn">+/-</div>
    <div @click="persent" class="btn">%</div>
    <div @click="operatorAction('/')" class="btn operation">/</div>
    <div @click="append('7')" class="btn">7</div>
    <div @click="append('8')" class="btn">8</div>
    <div @click="append('9')" class="btn">9</div>
    <div @click="operatorAction('*')" class="btn operation">*</div>
    <div @click="append('4')" class="btn">4</div>
    <div @click="append('5')" class="btn">5</div>
    <div @click="append('6')" class="btn">6</div>
    <div @click="operatorAction('-')" class="btn operation">-</div>
    <div @click="append('1')" class="btn">1</div>
    <div @click="append('2')" class="btn">2</div>
    <div @click="append('3')" class="btn">3</div>
    <div @click="operatorAction('+')" class="btn operation">+</div>
    <div @click="append('0')" class="btn zero">0</div>
    <div @click="dot" class="btn">.</div>
    <div @click="operatorAction('=')" class="btn operation">=</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      current: "",
      lastCurrent: null,
      operator: null,
      isOperator: false
    };
  },
  methods: {
    clear() {
      this.current = "";

      this.lastCurrent = null;
      this.operator = null;
      this.isOperator = false;
    },
    sign() {
      if (this.current && this.current.charAt(0) != "0") {
        this.current =
          this.current.charAt(0) == "-"
            ? this.current.slice(1)
            : `-${this.current}`;
      }
    },
    persent() {
      if (this.current) {
        this.current = `${parseFloat(this.current / 100.0)}`;
      }
    },
    append(number) {
      if (number == ".") {
        if (!this.current) {
          this.current = "0";
        }

        this.current = `${this.current}${number}`;
      } else {
        var current = String(this.current);
        if (
          (current.charAt(0) == "0" && current.indexOf(".") == -1) ||
          this.isOperator == true
        ) {
          this.current = `${number}`;
        } else {
          this.current = `${this.current}${number}`;
        }
      }

      this.isOperator = false;
    },
    dot() {
      if (this.current.indexOf(".") == -1) {
        this.append(".");
      }
    },
    operatorAction(res) {
      if (res == "=") {
        this.handleOperator();
        this.isOperator = false;
      } else {
        if (this.operator && this.lastCurrent && this.isOperator == false) {
          this.handleOperator();
        }

        this.isOperator = true;
        this.lastCurrent = `${this.current}`;
        this.operator = res;
      }
    },
    handleOperator() {
      if (this.operator && this.lastCurrent) {
        if (this.operator == "/") {
          this.current =
            parseFloat(this.lastCurrent) / parseFloat(this.current);
        } else if (this.operator == "*") {
          this.current =
            parseFloat(this.lastCurrent) * parseFloat(this.current);
        } else if (this.operator == "-") {
          this.current =
            parseFloat(this.lastCurrent) - parseFloat(this.current);
        } else if (this.operator == "+") {
          this.current =
            parseFloat(this.lastCurrent) + parseFloat(this.current);
        }
      }

      this.lastCurrent = null;
      this.operator = null;
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.calculator {
  font-size: 40px;
  text-align: center;

  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-auto-rows: minmax(55px, auto);

  border-radius: 15px;
}

.display {
  color: white;
  font-size: 80px;

  grid-column: 1/5;
  background-color: #333;

  padding-left: 20px;
  padding-right: 20px;
  padding-top: 40px;

  display: flex;
  flex-direction: row;
  justify-content: flex-end;
  align-items: flex-end;
}

.btn {
  background-color: #eee;
  border: solid 1px #333;

  padding-top: 20px;
  padding-bottom: 20px;
}

.zero {
  grid-column: 1/3;
}

.operation {
  background-color: orange;
}
</style>
