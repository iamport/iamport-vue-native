<script>
import { Platform } from 'react-native';
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
      marginTop: Platform.OS === 'ios' ? 20 : 0,
      userCode: 'imp10391932',
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
  <nb-container :style="{ marginTop }">
    <imp-certification
      :userCode="userCode"
      :data="params"
      :loading="loading"
      :callback="callback"
    />
  </nb-container>
</template>
