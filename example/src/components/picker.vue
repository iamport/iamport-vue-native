<script>
import React from 'react';
import { Dimensions } from 'react-native';
import { Picker, Header, Icon, Left, Button, Body, Title, Right } from 'native-base';

const { Item } = Picker;
export default {
  components: {
    Picker,
    Item,
  },
  props: {
    iosHeader: {
      type: String,
    },
    selectedValue: {
      type: String | Number,
    },
    data: {
      type: Array,
    },
    onValueChange: {
      type: Function,
    },
  },
  computed: {
    pickerWidth: () => {
      return Dimensions.get('window').width - 90 - 80;
    },
  },
  methods: {
    getPickerHeaderComp: function(backAction) {
      return (
        <Header style={{ backgroundColor: "#344e81" }}>
          <Left style={{ flex: 1 }}>
            <Button transparent onPress={backAction}>
              <Icon name="arrow-back" style={{ color: "#fff" }} />
            </Button>
          </Left>
          <Body style={{ flex: 3 }}>
            <Title style={{ textAlign: 'center', width: '100%' }}>{ this.iosHeader }</Title>
          </Body>
          <Right style={{ flex: 1 }} />
        </Header>
      );
    },
  },
}
</script>

<template>
   <nb-picker
    mode="dropdown"
    class="imp-picker"
    :renderHeader="getPickerHeaderComp"
    :style="{ width: pickerWidth }"
    :selectedValue="selectedValue"
    :onValueChange="onValueChange"
  >
    <item
      v-for="eachData in data"
      :label="eachData.label"
      :value="eachData.value"
      :key="eachData.value"
    />
  </nb-picker>
</template>

<style>
  .imp-picker {
    border-width: 1px;
    border-style: solid;
    border-color: #ccc;
    border-radius: 3px;
    height: 40px;
  }
</style>
