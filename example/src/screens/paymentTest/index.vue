<script>
import { Switch } from 'react-native';

import CustomPicker from '../../components/picker.vue';

import { getQuotas, getMethods } from '../../utils';
import { PGS } from '../../constants';

export default {
  components: {
    Switch,
    CustomPicker,
  },
  props: {
    navigation: {
      type: Object
    },
  },
  data() {
    return {
      pgs: PGS,
      methods: getMethods('html5_inicis'),
      quotas: getQuotas('html5_inicis'),
      pg: 'html5_inicis',
      pay_method: 'card',
      card_quota: 0,
      merchant_uid: `mid_${new Date().getTime()}`,
      name: '아임포트 데이터분석',
      amount: '39000',
      buyer_name: '홍길동',
      buyer_tel: '01012341234',
      buyer_email: 'example@example.com',
      vbank_due: '',
      biz_num: '',
      escrow: false,
      digital: false,
      isCardQuotaVisible: true,
      isVbankDueVisible: false,
      isBizNumVisible: false,
      isDigitalVisible: false,
    };
  },
  watch: {
    pg: function() {
      this.handleQuota();
      this.handleMethods();
    },
    pay_method: function() {
      this.handleParams();
    },
  },
  methods: {
    onSubmit() {
      const params = {
        pg: this.pg,
        pay_method: this.pay_method,
        merchant_uid: this.merchant_uid,
        name: this.name,
        amount: this.amount,
        buyer_name: this.buyer_name,
        buyer_tel: this.buyer_tel,
        buyer_email: this.buyer_email,
      };

      // 신용카드의 경우, 할부기한 추가
      if (this.pay_method === 'card' && this.card_quota !== 0) {
        params.display = {
          card_auota: this.card_auota === 1 ? [] : [this.card_quota],
        };
      }

      // 가상계좌의 경우, 입금기한 추가
      if (this.pay_method === 'vbank' && this.vbank_due) {
        params.vbank_due = this.vbank_due;
      }

      // 다날 && 가상계좌의 경우, 사업자 등록번호 10자리 추가
      if (this.pay_method === 'vbank' && this.pg === 'danal_tpay') {
        params.biz_num = this.biz_num;
      }

      // 휴대폰 소액결제의 경우, 실물 컨텐츠 여부 추가
      if (this.pay_method === 'phone') {
        params.digital = this.digital;
      }

      // 정기결제의 경우, customer_uid 추가
      if (this.pg === 'kcp_billing') {
        params.customer_uid = `cuid_${new Date().getTime()}`;
      }

      this.navigation.navigate('Payment', { params });
    },
    onPgChange(value) {
      this.pg = value;
    },
    onMethodChange(value) {
      this.pay_method = value;
    },
    onQuotaChange(value) {
      this.card_quota = value;
    },
    onEscrowChange(value) {
      this.escrow = value;
    },
    onDigitalChange(value) {
      this.digital = value;
    },
    handleParams() {
      // 신용카드의 경우, 할부기한 추가
      this.isCardQuotaVisible = this.pay_method === 'card';

      // 가상계좌의 경우, 입금기한 추가
      this.isVbankDueVisible = this.pay_method === 'vbank';

      // 다날 && 가상계좌의 경우, 사업자 등록번호 10자리 추가
      this.isBizNumVisible = this.pay_method === 'vbank' && this.pg === 'danal_tpay';

      // 휴대폰 소액결제의 경우, 실물 컨텐츠 여부 추가
      this.isDigitalVisible = this.pay_method === 'phone';
    },
    handleQuota() {
      this.quotas = getQuotas(this.pg);
      this.card_quota = this.quotas[0].value;
    },
    handleMethods() {
      this.methods = getMethods(this.pg);
      this.pay_method = this.methods[0].value;
    },
  }
}
</script>

<template>
  <nb-content>
    <nb-form ref="form" class="imp-form">
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">PG사</nb-label>
        <custom-picker
          iosHeader="PG사 선택"
          :data="pgs"
          :selectedValue="pg"
          :onValueChange="onPgChange"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">결제수단</nb-label>
        <custom-picker
          iosHeader="결제수단 선택"
          :data="methods"
          :selectedValue="pay_method"
          :onValueChange="onMethodChange"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item" v-if="isCardQuotaVisible">
        <nb-label class="imp-label">할부개월수</nb-label>
        <custom-picker
          iosHeader="할부 개월수 선택"
          :data="quotas"
          :selectedValue="card_quota"
          :onValueChange="onQuotaChange"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item" v-if="isVbankDueVisible">
        <nb-label class="imp-label">입금기한</nb-label>
        <nb-input
          class="imp-input"
          v-model="vbank_due"
          placeholder="YYYYMMDDhhmm"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item" v-if="isBizNumVisible">
        <nb-label class="imp-label">사업자번호</nb-label>
        <nb-input class="imp-input" v-model="biz_num" />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item" v-if="isDigitalVisible">
        <nb-label class="imp-label">실물 여부</nb-label>
        <Switch
          :value="digital"
          class="imp-switch"
          ios_backgroundColor="#ccc"
          :onValueChange="onDigitalChange"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">에스크로</nb-label>
        <Switch
          class="imp-switch"
          :value="escrow"
          ios_backgroundColor="#ccc"
          :onValueChange="onEscrowChange"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">주문명</nb-label>
        <nb-input class="imp-input" v-model="name" />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">결제금액</nb-label>
        <nb-input
          class="imp-input"
          v-model="amount"
          keyboardType="number-pad"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">이름</nb-label>
        <nb-input
          class="imp-input"
          v-model="buyer_name"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">연락처</nb-label>
        <nb-input
          class="imp-input"
          v-model="buyer_tel"
          keyboardType="number-pad"
        />
      </nb-item>
      <nb-item inlineLabel class="imp-form-item">
        <nb-label class="imp-label">이메일</nb-label>
        <nb-input
          class="imp-input"
          v-model="buyer_email"
        />
      </nb-item>
      <nb-button primary :onPress="onSubmit" class="imp-action">
        <nb-text class="imp-action-text">결제하기</nb-text>
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
    width: 100px;
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
 