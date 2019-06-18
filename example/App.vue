<script>
import React from 'react';
import { StackNavigator } from 'vue-native-router';
import Vue from 'vue-native-core';
import { VueNativeBase } from 'native-base';
import { View } from 'react-native';

import Home from './src/screens/home/index.vue';
import PaymentTest from './src/screens/paymentTest/index.vue';
import Payment from './src/screens/payment/index.vue';
import PaymentResult from './src/screens/paymentResult/index.vue';
import CertificationTest from './src/screens/certificationTest/index.vue';
import Certification from './src/screens/certification/index.vue';
import CertificationResult from './src/screens/certificationResult/index.vue';

Vue.use(VueNativeBase);

const navigationOptions = title => ({
  title,
  headerStyle: {
    height: 80,
    backgroundColor: '#344e81',
  },
  headerTitleStyle: {
    flex: 1,
    textAlign: 'center',
  },
  headerRight: <View />,
  headerTintColor: '#fff',
});

const hideHeader = {
  header: null,
};

const AppNavigation = StackNavigator(
  {
    Home: {
      screen: Home,
      navigationOptions: hideHeader,
    },
    PaymentTest: {
      screen: PaymentTest,
      navigationOptions: navigationOptions('아임포트 결제 테스트'),
    },
    Payment: {
      screen: Payment,
      navigationOptions: hideHeader,
    },
    PaymentResult: {
      screen: PaymentResult,
      navigationOptions: hideHeader,
    },
    CertificationTest: {
      screen: CertificationTest,
      navigationOptions: navigationOptions('아임포트 본인인증 테스트'),
    },
    Certification: {
      screen: Certification,
      navigationOptions: hideHeader,
    },
    CertificationResult: {
      screen: CertificationResult,
      navigationOptions: hideHeader,
    },
  },
  {
    initialRouteName: 'Home',
  },
);

export default {
  components: { AppNavigation },
}
</script>

<template>
  <app-navigation />
</template>
