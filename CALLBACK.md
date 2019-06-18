
# iamport-react-native
[ ![alt text](https://img.shields.io/badge/react-v16.8.6-orange.svg?longCache=true&style=flat-square) ](https://github.com/facebook/react/)
[ ![alt text](https://img.shields.io/badge/react--native-v0.59.8-yellow.svg?longCache=true&style=flat-square) ](https://github.com/facebook/react-native)
[ ![alt text](https://img.shields.io/badge/query--string-v6.1.0-green.svg?longCache=true&style=flat-square) ](https://github.com/sindresorhus/query-string)

아임포트 뷰 네이티브 예제 프로젝트 콜백 설정 안내입니다.

## 콜백 함수 설정하기
#### 1. 콜백은 필수입력
콜백 함수는 필수입력 필드로, 결제/본인인증 완료 후 실패/성공 여부에 맞게 로직을 작성할 수 있습니다.
<b>콜백 함수를 설정하지 않으면, 결제/본인인증 완료 후 아래와 같이 아임포트가 기본적으로 제공하는 페이지(PG사에 따라 로딩화면이 보여지는 경우도 있음)로 넘어가게 됩니다.</b>
따라서 <span style="color: #f5222d">반드시 callback 함수를 설정</span>해주어야 합니다.

![](https://github.com/iamport/iamport-react-native/blob/master/src/img/iamport-default-page.png)


#### 2. 콜백 함수 작성하기
결제/본인인증 완료 후 [react-navigation](https://github.com/react-navigation/react-navigation)를 통해 라우터를 변경하는 경우, 아래와 같이 [push 함수](https://reactnavigation.org/docs/en/stack-actions.html#push)가 아닌 [replace 함수](https://reactnavigation.org/docs/en/stack-actions.html#replace)를 사용해야 합니다.
push 함수를 사용할 경우, 결제 완료 후 라우터가 변경되더라도 유저가 뒤로가기를 했을 경우 아임포트 모듈이 다시 렌더링됩니다. 하지만 replace 함수를 사용하면, 결제 완료 후 라우터가 변경되고 유저가 뒤로가기를 하면 원래 결제화면으로 넘어가게 됩니다.

### 잘못된 사용 예제
```javascript
methods: {
  callback(response) {
    this.navigation.push('PaymentResult', { response }); // [에러] push 함수 사용
  },
},
```

### 올바른 사용 예제
```javascript
methods: {
  callback(response) {
    this.navigation.replace('PaymentResult', { response });
  },
},
```

#### 3. 결과에 따라 로직 작성하기
콜백 함수의 첫번째 인자(response)는 결제/본인인증 결과를 담고 있는 오브젝트로 아래와 같이 구성되어 있습니다.

| key                     |  Description       | 
| ----------------------- | ------------------ | 
| success 또는 imp_success | 성공 여부            |
| imp_uid                 | 아임포트 번호         |
| merchant_uid            | 주문번호             |
| error_msg               | 실패한 경우, 에러메시지 |

결제/본인인증 성공 여부는 `success` 또는 `imp_success`값(이하 성공 여부)으로 판단하며 어떤 값이 전달되는지는 PG사마다 차이가 있습니다. 아래 코드는 이해를 돕기 위한 예시일 뿐, 성공 여부로 실제 결제 완료 여부를 판단하면 안됩니다. 여기서 말하는 `성공`이 항상 `결제완료`를 의미하는 것은 아니기 때문입니다.

`결제완료` 여부는 결제 위변조 여부 확인 후, [아임포트 API](https://api.iamport.kr/) 결제내역 조회(`GET` `/payments/${imp_uid}`)의 `status`값으로 판단해야 합니다. 자세한 내용은 아임포트 메뉴얼 [결제 위변조 여부 검증 후 데이터 동기화하기](https://docs.iamport.kr/implementation/payment#webhook-3)를 참고해주세요.

```html
<script>
export default {
  props: {
    navigation: {
      type: Object,
    },
  },
  computed: {
    success: function() {
      const { success } = this.navigation.getParam('response');
      return success === 'true';
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
  <view v-if="success">
    <text>본인인증에 성공하였습니다</text>
    <nb-list>
      <nb-list-item>
        <nb-text>아임포트 번호</nb-text>
        <nb-text>{{ imp_uid }}</nb-text>
      </nb-list-item>
      <nb-list-item>
        <nb-text>주문번호</nb-text>
        <nb-text>{{ merchant_uid }}</nb-text>
      </nb-list-item>
    </nb-list>
    <nb-button bordered transparent>
      <nb-text :onPress="onGoBack">돌아가기</nb-text>
    </nb-button>
  </view>
  <view v-else>
    <text>본인인증에 실패하였습니다</text>
    <nb-list>
      <nb-list-item>
        <nb-text>아임포트 번호</nb-text>
        <nb-text>{{ imp_uid }}</nb-text>
      </nb-list-item>
      <nb-list-item>
        <nb-text>에러 메시지</nb-text>
        <nb-text>{{ error_msg }}</nb-text>
      </nb-list-item>
    </nb-list>
    <nb-button bordered transparent>
      <nb-icon name="arrow-back" />
      <nb-text :onPress="onGoBack">돌아가기</nb-text>
    </nb-button>
  </view>
</template>
...
```
