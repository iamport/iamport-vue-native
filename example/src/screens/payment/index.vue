<script>
import { Platform } from 'react-native';
import IMP from 'iamport-react-native';

import { getUserCode } from '../../utils';

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
      marginTop: Platform.OS === 'ios' ? 20 : 0,
      app_scheme: 'example',
      loading: {
        message: '잠시만 기다려주세요...',
      },
    };
  },
  computed: {
    userCode: function() {
      const { pg } = this.navigation.getParam('params');
      return getUserCode(pg);
    },
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
  <nb-container :style="{ marginTop }">
    <imp-payment
      :userCode="userCode"
      :data="paymentData"
      :loading="loading"
      :callback="callback"
    />
  </nb-container>
</template>
