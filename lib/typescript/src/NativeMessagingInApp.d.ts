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
declare const _default: MessagingInAppInterface;
export default _default;
//# sourceMappingURL=NativeMessagingInApp.d.ts.map