<script>
export default {
  props: {
    navigation: {
      type: Object,
    }
  },
}
</script>

<template>
  <view class="wrapper">
    <view class="container">
      <view class="header-container">
        <text class="header-title">아임포트 테스트</text>
        <text class="header-text">아임포트 뷰 네이티브 모듈 테스트 화면입니다.</text>
        <text class="header-text">아래 버튼을 눌러 결제 또는 본인인증 테스트를 진행해주세요.</text>
      </view>
      <view class="module-container">
        <touchable-opacity
          class="module"
          :onPress="() => navigation.navigate('PaymentTest')"
        >
          <nb-icon type="AntDesign" name="creditcard" />
          <text class="module-title">결제 테스트</text>
        </touchable-opacity>
        <touchable-opacity
          class="module"
          :onPress="() => navigation.navigate('CertificationTest')"
        >
          <nb-icon type="AntDesign" name="user" />
          <text class="module-title">본인인증 테스트</text>
        </touchable-opacity>
      </view>
    </view>
  </view>
</template>

<style>
  .wrapper {
    flex: 1;
  }
  .container {
    flex: 0.5;
    position: relative;
    text-align: center;
    background-color: #344e81;
  }
  .header-container {
    align-items: center;
    justify-content: center;
    flex: 1;
  }
  .header-text {
    color: #fff;
    line-height: 20px;
  }
  .header-title {
    color: #fff;
    font-size: 20px;
    margin-bottom: 10px;
    font-weight: bold;
  }

  .module-container {
    position: absolute;
    bottom: -50px;
    height: 100px;
    width: 90%;
    margin-left: 5%;
    margin-right: 5%;
    align-items: center;
    justify-content: center;
    flex-direction: row;
  }
  .module {
    width: 45%;
    margin-left: 2.5%;
    margin-right: 2.5%;
    height: 100px;
    background-color: #fff;
    border-radius: 3px;
    flex: 1;
    align-items: center;
    justify-content: center;
    shadow-color: rgba(0, 0, 0, 0.3);
    shadow-opacity: 1.0;
  }
  .module-title {
    font-size: 16px;
    margin-top: 10px;
  }
</style>
