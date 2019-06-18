
# iamport-react-native
[ ![alt text](https://img.shields.io/badge/react-v16.8.6-orange.svg?longCache=true&style=flat-square) ](https://github.com/facebook/react/)
[ ![alt text](https://img.shields.io/badge/react--native-v0.59.8-yellow.svg?longCache=true&style=flat-square) ](https://github.com/facebook/react-native)
[ ![alt text](https://img.shields.io/badge/query--string-v6.1.0-green.svg?longCache=true&style=flat-square) ](https://github.com/sindresorhus/query-string)

아임포트 뷰 네이티브 예제 프로젝트입니다. 뷰 네이티브는 뷰 자바스크립트와 리액트 네이티브를 연결하기 때문에, 뷰 네이티브 프로젝트에서 리액트 네이티브 라이브러리를 사용하실 수 있습니다. 따라서 아임포트 뷰 네이티브 모듈은 예제 프로젝트만 제공하고 있으머, 아래 내용은 뷰 네이티브 프로젝트에서 아임포트 리액트 네이티브 모듈을 사용하기 위한 안내입니다.

## 목차
- [버전정보](https://github.com/iamport/iamport-react-native/blob/master/VERSION.md)
- [지원정보](https://github.com/iamport/iamport-react-native/blob/master/SUPPORT.md)
- [설치하기](https://github.com/iamport/iamport-react-native/blob/master/INSTALL.md)
- [설정하기](https://github.com/iamport/iamport-react-native/blob/master/SETTING.md)
- [예제](EXAMPLE.md)
- [콜백 함수 설정하기](CALLBACK.md)
- 아임포트 asset 추가하기

## 버전정보
최신버전은 [v1.1.0](https://github.com/iamport/iamport-react-native/tree/master)입니다. 버전 히스토리는 [버전정보](VERSION.md)를 참고하세요.

## 지원정보
아임포트 뷰 네이티브 모듈은 결제 및 휴대폰 본인인증 기능을 제공합니다. 결제시 지원하는 PG사와 결제수단에 대한 자세한 정보는 [지원정보](SUPPORT.md)를 참고하세요.

## 설치하기
아래 명령어를 통해 아임포트 모듈을 귀하의 뷰 네이티브 프로젝트에 추가할 수 있습니다. 보다 자세한 안내는 [설치하기](INSTALL.md)를 참고하세요.

```
$ npm install iamport-react-native --save
```

아래 다음 명령어를 통해 아임포트 모듈을 귀하의 안드로이드/IOS 프로젝트에 추가할 수 있습니다.

```
$ npm install -g react-native-cli
$ react-native link iamport-react-native
$ react-native link react-native-webview // v1.1.0 이상 필수
```

## 설정하기(IOS)
IOS에서 아임포트 결제연동 모듈을 사용하기 위해서는 아래 3가지 항목을 설정해주셔야 합니다. 보다 자세한 설명은 [설정하기](SETTING.md)를 참고하세요.

#### 1. App Scheme 등록
외부 결제 앱(예) 페이코, 신한 판 페이)에서 결제 후 돌아올 때 사용할 URL identifier를 설정해야합니다.

![](src/img/app-scheme-registry.gif)


#### 2. 외부 앱 리스트 등록
3rd party앱(예) 간편결제 앱)을 실행할 수 있도록 외부 앱 리스트를 등록해야합니다. 

```html
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>kakao0123456789abcdefghijklmn</string>
  <string>kakaokompassauth</string>
  <string>storykompassauth</string>
  <string>kakaolink</string>
  <string>kakaotalk</string>
  <string>kakaostory</string>
  <string>storylink</string>
  <string>payco</string>
  <string>kftc-bankpay</string>
  <string>ispmobile</string>
  <string>itms-apps</string>
  <string>hdcardappcardansimclick</string>
  <string>smhyundaiansimclick</string>
  <string>shinhan-sr-ansimclick</string>
  <string>smshinhanansimclick</string>
  <string>kb-acp</string>
  <string>mpocket.online.ansimclick</string>
  <string>ansimclickscard</string>
  <string>ansimclickipcollect</string>
  <string>vguardstart</string>
  <string>samsungpay</string>
  <string>scardcertiapp</string>
  <string>lottesmartpay</string>
  <string>lotteappcard</string>
  <string>cloudpay</string>
  <string>nhappvardansimclick</string>
  <string>nonghyupcardansimclick</string>
  <string>nhallonepayansimclick</string>
  <string>citispay</string>
  <string>citicardappkr</string>
  <string>citimobileapp</string>
  <string>itmss</string>
  <string>lpayapp</string>
  <string>kpay</string>
</array>
```


#### 3. App Transport Security 설정

![](src/img/allow-arbitrary.gif)

```html
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoadsInWebContent</key>
  <true/>
  <key>NSAllowsArbitraryLoads</key>
  <true/>
</dict>
```


## 예제
아임포트 결제연동 모듈을 사용해 아래와 같이 일반/정기결제 및 휴대폰 본인인증 기능을 구현할 수 있습니다. 필요한 파라미터는 [예제](EXAMPLE.md)를 참고하세요.

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


## 콜백 함수 설정하기
콜백 함수는 필수입력 필드로, 결제/본인인증 완료 후 실패/성공 여부에 맞게 아래와 같이 로직을 작성할 수 있습니다. 콜백 함수에 대한 자세한 설명은 [콜백 설정하기](CALLBACK.md)를 참고하세요.

```javascript
methods: {
  callback(response) {
    this.navigation.replace('CertificationResult', { response });
  },
},
```


## 아임포트 asset 추가하기
개발 모드와는 달리, 릴리즈 모드에서 결제 창이 뜨지 않고 white screen으로 머물러있다는 문의가 종종 있습니다. 이는 프로젝트 배포를 위한 bundle 파일을 만들때, 아임포트 asset(`payment.html`, `certification.html`)이 제대로 추가되지 않았기 때문입니다. 뷰 네이티브는 리액트 네이티브와 마찬가지로 아래와 같이 `bundle 명령어`를 통해 bundle 파일을 만들고 필요한 asset을 추가(`copy`)합니다.

### IOS bundle 명령어
`ios` 폴더 하위에 `main.jsbundle` 파일과 `assets` 폴더를 생성합니다.

```bash
$ react-native bundle --entry-file index.js --platform ios --dev false --bundle-output ios/main.jsbundle --assets-dest ios
```

### Android bundle 명령어
`android/app/src/main` 폴더 하위에 `assets` 폴더를 생성하고, 그 하위에 `index.android.bundle` 파일을 생성합니다.

```bash
$ mkdir android/app/src/main/assets
$ react-native bundle --platform android --dev false --entry-file index.js --bundle-output android/app/src/main/assets/index.android.bundle --assets-dest android/app/src/main/res
```

추가(copy)된 asset은 아래와 같습니다.

### IOS assets

```bash
├── ios
│   ├── assets
│   │   └── node_modules
│   │       ├── iamport-react-native
│   │       │   └── src
│   │       │       ├── html
│   │       │       │   ├── payment.html // 아임포트 결제 asset
│   │       │       │   └── certification.html // 아임포트 휴대폰 본인인증 asset
│   │       │       └── img
│   │       │           └── iamport-logo.png
│   │       └── ...
│   ├── main.jsbundle // bundle 파일
│   └── ...
└── ...
```

### Android assets

```bash
├── android
│   ├── app
│   │   ├── src
│   │   │   └── main
│   │   │       ├── assets
│   │   │       │   ├── index.android.bundle // bundle 파일
│   │   │       │   └── ...
│   │   │       ├── res
│   │   │       │   ├── raw
│   │   │       │   │   ├── node_modules_iamportreactnative_src_html_certification.html // 아임포트 휴대폰 본인인증 asset
│   │   │       │   │   └── ...
│   │   │       │   └── ...
│   │   │       └── ...
│   │   └── ...    
│   └── ...       
└── ...       
```

릴리즈 모드에서 결제 창이 뜨지 않고 white screen으로 머물러있다면 위와 같이 아임포트 asset이 잘 포함되어있는지 확인해보시길 바랍니다.
