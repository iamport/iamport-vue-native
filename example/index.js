/**
 * @format
 */

import React from 'react';
import { AppRegistry } from 'react-native';
import { StyleProvider } from 'native-base';
import getTheme from './native-base-theme/components';
import material from './native-base-theme/variables/material';

import App from './App';
import { name as appName } from './app.json';

const Root = () => (
  <StyleProvider style={getTheme(material)}>
    <App />
  </StyleProvider>
);

AppRegistry.registerComponent(appName, () => Root);
