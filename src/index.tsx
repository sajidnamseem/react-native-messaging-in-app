import MessagingInApp from './NativeMessagingInApp';
import type { MessagingConfig } from './NativeMessagingInApp';

export function launchChat(config: MessagingConfig): Promise<void> {
  return MessagingInApp.launchChat(config);
}

export type { MessagingConfig };
export default MessagingInApp;
