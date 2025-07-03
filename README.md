# react-native-messaging-in-app

Salesforce React Native messaging library for in-app chat functionality

## Installation

```sh
npm install react-native-messaging-in-app
```

## Usage

```js
import { launchChat } from 'react-native-messaging-in-app';

// Launch chat with configuration
const config = {
  serviceAPI: 'https://your-service-api.com',
  organizationId: 'your-org-id',
  developerName: 'your-developer-name',
  userVerificationRequired: false,
  language: 'en',
  chatMedium: 'mobile',
  brand: 'your-brand',
  country: 'US'
};

try {
  await launchChat(config);
} catch (error) {
  console.error('Failed to launch chat:', error);
}
```

## Configuration Options

The `launchChat` function accepts a configuration object with the following properties:

- `serviceAPI` (string, required): The URL of your service API
- `organizationId` (string, required): Your organization ID
- `developerName` (string, required): Your developer name
- `userVerificationRequired` (boolean, optional): Whether user verification is required (default: false)
- `language` (string, optional): Language code for the chat interface
- `chatMedium` (string, optional): Medium identifier for the chat
- `brand` (string, optional): Brand identifier
- `country` (string, optional): Country code

## Dependencies

### iOS Dependencies
This library requires the following iOS dependencies:
- SMIClientUI
- SMIClientCore

Make sure these are properly configured in your iOS project.

### Android Dependencies
This library requires the following Android dependencies:
- `com.salesforce.android:smi-core`
- `com.salesforce.android:smi-ui`

The Android dependencies are automatically included via the library's build.gradle file.

## Platform Support

- ✅ iOS (Swift/Objective-C)
- ✅ Android (Kotlin)

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
