"use strict";

import { NativeModules } from 'react-native';
// Debug: Log all available native modules
console.log('Available NativeModules:', Object.keys(NativeModules));
const {
  MessagingModule
} = NativeModules;

// Debug: Log the MessagingModule
console.log('MessagingModule:', MessagingModule);
export default MessagingModule;
//# sourceMappingURL=NativeMessagingInApp.js.map