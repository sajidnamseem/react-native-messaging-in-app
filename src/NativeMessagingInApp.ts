import { NativeModules } from 'react-native';

export interface MessagingConfig {
  serviceAPI?: string;
  organizationId?: string;
  developerName?: string;
  userVerificationRequired?: boolean;
  language?: string;
  chatMedium?: string;
  brand?: string;
  country?: string;
}

export interface MessagingInAppInterface {
  launchChat(config: MessagingConfig): Promise<void>;
}

// Debug: Log all available native modules
console.log('Available NativeModules:', Object.keys(NativeModules));

const { MessagingModule } = NativeModules;

// Debug: Log the MessagingModule
console.log('MessagingModule:', MessagingModule);

export default MessagingModule as MessagingInAppInterface;
