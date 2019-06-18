# iamport-react-native
[ ![alt text](https://img.shields.io/badge/react-v16.8.6-orange.svg?longCache=true&style=flat-square) ](https://github.com/facebook/react/)
[ ![alt text](https://img.shields.io/badge/react--native-v0.59.8-yellow.svg?longCache=true&style=flat-square) ](https://github.com/facebook/react-native)
[ ![alt text](https://img.shields.io/badge/query--string-v6.1.0-green.svg?longCache=true&style=flat-square) ](https://github.com/sindresorhus/query-string)

아임포트 뷰 네이티브 예제 프로젝트 안내입니다.

## 예제 프로젝트
#### IOS
##### 1. 디바이스
  - [XCode를 설치](https://developer.apple.com/xcode)합니다.
  - IOS 디바이스를 컴퓨터에 연결합니다.
  - XCode 프로젝트(`iamport-vue-native/example/ios/example.xcodeproj`)를 더블클릭해 오픈합니다.
  - `Cmd+R`를 눌러 앱을 빌드합니다.
  - 빌드가 성공하고 디바이스에 example 앱이 설치된 것을 확인하실 수 있습니다.

##### 2. Emulator
  - 아래 명령어를 입력해 IOS emulator를 실행시켜 아임포트 모듈 결제테스트를 진행하실 수 있습니다.
  ```
  $ cd iamport-vue-native/example
  $ npm install
  $ react-native link iamport-react-native
  $ react-native link react-native-webview // iamport-react-native v1.1.0 이상 필수
  $ react-native run-ios
  ```

#### 안드로이드
##### 1. 디바이스
  - 안드로이드 디바이스를 컴퓨터에 연결합니다.
  - 아래 명령어를 입력해 앱을 빌드합니다.
    ```
    $ cd iamport-vue-native/example
    $ npm install
    $ react-native link iamport-react-native
    $ react-native link react-native-webview
    $ react-native run-android
    ```
  - 빌드가 성공하고 example 앱이 디바이스에 설치된 것을 확인하실 수 있습니다.

##### 2. Emulator
  - [안드로이드 스튜디오를 설치](https://developer.android.com/studio)합니다.
  - 안드로이드 프로젝트(`iamport-vue-native/example/android`)를 안드로이드 스튜디오에서 오픈합니다.
  - ![](https://github.com/iamport/iamport-react-native/raw/master/src/img/android-studio-build.png) 또는 `Cmd+F9`를 눌러 앱을 빌드합니다.
  - ![AVD Manager](https://github.com/iamport/iamport-react-native/raw/master/src/img/android-studio-avd-manager.png)을 눌러 안드로이드 emulator를 실행시킵니다.
  - example 앱이 설치된 것을 확인하실 수 있습니다.

![](https://github.com/iamport/iamport-react-native/raw/master/src/img/ios-emulator-home.png)
![](https://github.com/iamport/iamport-react-native/raw/master/src/img/ios-emulator-payment.png)
![](https://github.com/iamport/iamport-react-native/raw/master/src/img/ios-emulator-certification.png)



#### 1. 일반/정기결제 사용예제
```html
<script>
import IMP from 'iamport-react-native';

const ImpPayment = IMP.Payment;

export default {
  components: { ImpPayment },
  props: {
    navigation: {
      type: Object
    },
  },
  data() {
    return {
      userCode: 'iamport',
      app_scheme: 'example',
      loading: {
        message: '잠시만 기다려주세요...',
      },
    };
  },
  computed: {
    paymentData: function() {
      const params = this.navigation.getParam('params');
      return {
        ...params,
        app_scheme: this.app_scheme,
      };
    },
  },
  methods: {
    callback(response) {
      this.navigation.replace('PaymentResult', { response });
    },
  },
}
</script>

<template>
  <imp-payment
    :userCode="iamport"
    :data="paymentData"
    :loading="loading"
    :callback="callback"
  />
</template>
```

| Prop             | Type          |  Description                                                | Default             | Required   |
| ---------------- | ------------- | ----------------------------------------------------------- | ------------------- | ---------- |
| userCode         | string        | 가맹점 식별코드                                                 | undefined           | true       |
| data             | object        | 결제에 필요한 정보 [자세히 보기](https://docs.iamport.kr/tech/imp) | undefined           | true       |
| - m_redirect_url | string        | [Deprecated]                                                | undefined           | false       |
| callback         | function      | 결제 후 실행 될 함수 [자세히보기](#callback)                       | undefined           | true       |
| loading          | object        | 로딩 화면 커스터마이징 위한 메시지 및 이미지                          |                     | false      |
| - message        | string        | 로딩화면 메시지                                                 | 잠시만 기다려주세요...    | false      |
| - image          |               | 로딩화면 이미지(url도 가능)                                       | 아임포트 로고 이미지     | false      |




#### 2. 휴대폰 본인인증 사용예제
```html
<script>
import IMP from 'iamport-react-native';

const ImpCertification = IMP.Certification;

export default {
  components: { ImpCertification },
  props: {
    navigation: {
      type: Object
    },
  },
  data() {
    return {
      userCode: 'iamport',
      loading: {
        message: '잠시만 기다려주세요...',
      },
    };
  },
  computed: {
    params: function() {
      return this.navigation.getParam('params');
    },
  },
  methods: {
    callback(response) {
      this.navigation.replace('CertificationResult', { response });
    },
  },
}
</script>

<template>
  <imp-certification
    :userCode="userCode"
    :data="params"
    :loading="loading"
    :callback="callback"
  />
</template>
```

| Prop          | Type          |  Description                       | Default             | Required   |
| ------------- | ------------- | ---------------------------------- | ------------------- | ---------- |
| userCode      | string        | 가맹점 식별코드                        | undefined           | true       |
| data          | object        | 본인인증에 필요한 정보                   | undefined           | true       |
| - merchant_uid| string        | 가맹점 주문번호                        | random              | false      |
| - min_age     | number        | 본인인증 허용 최소 연령                  | undefined           | false      |
| callback      | function      | 본인인증 후 실행 될 함수                 | undefined           | true       |
| loading       | object        | 로딩 화면 커스터마이징 위한 메시지 및 이미지  |                     | false      |
| - message     | string        | 로딩화면 메시지                        | 잠시만 기다려주세요...   | false      |
| - image       |               | 로딩화면 이미지(url도 가능)              | 아임포트 로고 이미지     | false      |
