<script>
export default {
  props: {
    navigation: {
      type: Object,
    },
  },
  computed: {
    // [WARNING: 이해를 돕기 위한 것일 뿐, imp_success 또는 success 파라미터로 결제 성공 여부를 장담할 수 없습니다.]
    // 아임포트 서버로 결제내역 조회(GET /payments/${imp_uid})를 통해 그 응답(status)에 따라 결제 성공 여부를 판단하세요.
    success: function() {
      const { imp_success, success } = this.navigation.getParam('response');
      return !(imp_success === 'false' || imp_success === false || success === 'false' || success === false);
    },
    imp_uid: function() {
      const { imp_uid } = this.navigation.getParam('response');
      return imp_uid;
    },
    merchant_uid: function() {
      const { merchant_uid } = this.navigation.getParam('response');
      return merchant_uid;
    },
    error_msg: function() {
      const { error_msg } = this.navigation.getParam('response');
      return error_msg;
    },
  },
  methods: {
    onGoBack() {
      this.navigation.replace('Home');
    },
  },
}
</script>

<template>
  <view class="imp-result-wrapper" v-if="success">
    <nb-icon
      type="AntDesign"
      name="checkcircle"
      class="imp-result-icon"
      :style="{ color: '#52c41a' }"
    />
    <text class="imp-result">결제에 성공하였습니다</text>
    <nb-list class="imp-result-lists">
      <nb-list-item class="imp-result-list">
        <nb-text class="list-label">아임포트 번호</nb-text>
        <nb-text class="list-value">{{ imp_uid }}</nb-text>
      </nb-list-item>
      <nb-list-item class="imp-result-list">
        <nb-text class="list-label">주문번호</nb-text>
        <nb-text class="list-value">{{ merchant_uid }}</nb-text>
      </nb-list-item>
    </nb-list>
    <nb-button
      bordered
      transparent
      class="imp-btn-back btn-success"
    >
      <nb-icon name="arrow-back" class="icon-success" />
      <nb-text class="imp-btn-text text-success" :onPress="onGoBack">돌아가기</nb-text>
    </nb-button>
  </view>
  <view class="imp-result-wrapper" v-else>
    <nb-icon
      type="AntDesign"
      name="exclamationcircle"
      class="imp-result-icon"
      :style="{ color: '#f5222d' }"
    />
    <text class="imp-result">결제에 실패하였습니다</text>
    <nb-list class="imp-result-lists">
      <nb-list-item class="imp-result-list">
        <nb-text class="list-label">아임포트 번호</nb-text>
        <nb-text class="list-value">{{ imp_uid }}</nb-text>
      </nb-list-item>
      <nb-list-item class="imp-result-list">
        <nb-text class="list-label">에러 메시지</nb-text>
        <nb-text class="list-value">{{ error_msg }}</nb-text>
      </nb-list-item>
    </nb-list>
    <nb-button
      bordered
      transparent
      class="imp-btn-back btn-failure"
    >
      <nb-icon iconLeft active name="arrow-back" class="icon-failure" />
      <nb-text class="imp-btn-text text-failure" :onPress="onGoBack">돌아가기</nb-text>
    </nb-button>
  </view>
</template>

<style>
  .imp-result-wrapper {
    flex: 1;
    margin: 10px;
    align-items: center;
    justify-content: center;
    flex-direction: column;
    border-radius: 3px;
    background-color: #fff;
  }
  .imp-result-icon {
    font-size: 100;
    text-align: center;
    margin-bottom: 20px;
  }
  .imp-result {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
  }
  .imp-result-lists {
    width: 90%;
    margin-bottom: 50px;
  }
  .imp-result-list {
    border-bottom-width: 0;
    margin-top: -10px;
    margin-bottom: -10px;
  }
  .list-label {
    width: 40%;
    color: rgba(0, 0, 0, 0.6);
  }
  .list-value {
    width: 60%;
  }
  .imp-btn-back {
    margin-left: auto;
    margin-right: auto;
  }
  .btn-success {
    border-color: #52c41a;
  }
  .btn-failure {
    border-color: #f5222d;
  }
  .icon-success {
    color: #52c41a;
  }
  .icon-failure {
    color: #f5222d;
  }
  .imp-btn-text {
    font-size: 16px;
    font-weight: bold;
    margin-left: -20px;
  }
  .text-success {
    color: #52c41a;
  }
  .text-failure {
    color: #f5222d;
  }
</style>
