<script>
export default {
  props: {
    navigation: {
      type: Object
    },
  },
  data() {
    return {
      merchant_uid: `mid_${new Date().getTime()}`,
      name: '',
      phone: '',
      min_age: '',
    };
  },
  methods: {
    onSubmit() {
      const params = {
        merchant_uid: this.merchant_uid,
      };
      if (this.name) {
        params.name = this.name;
      }
      if (this.phone) {
        params.phone = this.phone;
      }
      if (this.min_age) {
        params.min_age = this.min_age;
      }
      this.navigation.navigate('Certification', { params });
    },
  }
}
</script>

<template>
  <nb-content>
    <nb-form ref="form" class="imp-form">
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">주문번호</nb-label>
        <nb-input class="imp-input" v-model="merchant_uid" />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">이름</nb-label>
        <nb-input class="imp-input" v-model="name" />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">전화번호</nb-label>
        <nb-input
          class="imp-input"
          keyboardType="number-pad"
          v-model="phone"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">최소연령</nb-label>
        <nb-input
          class="imp-input"
          keyboardType="number-pad"
          placeholder="허용 최소 만 나이"
          v-model="min_age"
        />
      </nb-item>
      <nb-button primary :onPress="onSubmit" class="imp-action">
        <nb-text class="imp-action-text">본인인증 하기</nb-text>
      </nb-button>
    </nb-form>
  </nb-content>
</template>

<style>
  .imp-form {
    padding: 20px;
    margin: 20px;
    background-color: #fff;
    border-radius: 3px;
  }
  .imp-form-item {
    margin-bottom: 5px;
    padding-left: 0;
    margin-left: 0;
    border-bottom-width: 0;
  }
  .imp-label {
    width: 90px;
    font-size: 16px;
  }
  .imp-input {
    border-width: 1px;
    border-style: solid;
    border-color: #ccc;
    border-radius: 3px;
    height: 40px;
    font-size: 14px;
    padding-left: 10px;
  }
  .imp-switch {
    margin-top: 5px;
    margin-bottom: 5px;
  }
  .imp-action {
    margin-top: 15px;
    margin-left: auto;
    margin-right: auto;
  }
  .imp-action-text {
    font-size: 16px;
    width: 100%;
    text-align: center;
  }
</style>
 