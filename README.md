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

## Platform Setup

### iOS Setup

#### Dependencies
This library requires the following iOS dependencies:
- SMIClientUI
- SMIClientCore

The iOS dependencies are automatically included via the library's podspec file.

#### Installation Steps
1. Install the library: `npm install react-native-messaging-in-app`
2. Run `cd ios && pod install` to install the iOS dependencies
3. Build and run your iOS app

### Android Setup

#### Prerequisites
- Android Studio
- Android SDK (API level 24 or higher)
- Kotlin support enabled

#### Step-by-Step Installation

1. **Install the library**
   ```bash
   npm install react-native-messaging-in-app
   ```

2. **Add Salesforce Maven Repository**
   
   In your app-level `build.gradle` file (`android/app/build.gradle`), add the Salesforce repository:
   ```gradle
   repositories {
       mavenCentral()
       google()
       // Add Salesforce repository for messaging SDK
       maven { url "https://s3.amazonaws.com/inapp.salesforce.com/public/android" }
   }
   ```

3. **Add Salesforce Dependencies**
   
   In your app-level `build.gradle` file, add the dependency:
   ```gradle
   dependencies {
       // ... other dependencies
       
       // Salesforce messaging dependency
       implementation "com.salesforce.service:messaging-inapp-ui:1.9.0"
   }
   ```

4. **Enable Data Binding**
   
   In your app-level `build.gradle` file, enable data binding:
   ```gradle
   android {
       // ... other configurations
       
       buildFeatures {
           dataBinding true
       }
   }
   ```

5. **Sync and Build**
   ```bash
   cd android
   ./gradlew clean
   ./gradlew build
   ```

6. **Run the App**
   ```bash
   npx react-native run-android
   ```

#### Troubleshooting Android Issues

**Blank Screen Issue:**
If you encounter a blank screen, follow these steps:

1. **Check Module Registration**
   - Ensure the native module is properly registered
   - Check the console logs for any module registration errors
   - Verify that `MessagingModule` appears in the available native modules

2. **Clean and Rebuild**
   ```bash
   cd android
   ./gradlew clean
   cd ..
   npx react-native run-android
   ```

3. **Check Dependencies**
   - Verify that the Salesforce repository is accessible
   - Ensure the dependency version is correct
   - Check that data binding is enabled

4. **Debug Module Loading**
   Add this to your app to debug module loading:
   ```javascript
   import { NativeModules } from 'react-native';
   console.log('Available NativeModules:', Object.keys(NativeModules));
   ```

**Build Errors:**
- If you get dependency resolution errors, ensure the Salesforce repository is properly added
- If you get compilation errors, check that the import statements match the dependency package names

**Common Error Solutions:**

1. **"Could not find com.salesforce.service:messaging-inapp-ui"**
   - Verify the Maven repository URL is correct
   - Check your internet connection
   - Try using a different version if available

2. **"Module not found" errors**
   - Clean and rebuild the project
   - Check that the module name matches between native code and JavaScript

3. **"Blank screen" after launch**
   - Check the console for JavaScript errors
   - Verify the configuration parameters are correct
   - Ensure the native module is properly registered

#### Example Configuration

Here's a complete example of how to use the library:

```javascript
import React, { useState } from 'react';
import { View, Button, Alert } from 'react-native';
import { launchChat } from 'react-native-messaging-in-app';

export default function App() {
  const [isLoading, setIsLoading] = useState(false);

  const handleLaunchChat = async () => {
    setIsLoading(true);
    try {
      const config = {
        serviceAPI: 'https://your-service-api.com',
        organizationId: 'your-org-id',
        developerName: 'your-developer-name',
        userVerificationRequired: false,
        language: 'en',
        chatMedium: 'mobile',
        brand: 'your-brand',
        country: 'US',
      };

      await launchChat(config);
      Alert.alert('Success', 'Chat launched successfully!');
    } catch (error) {
      Alert.alert('Error', `Failed to launch chat: ${error}`);
      console.error('Chat launch error:', error);
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Button
        title={isLoading ? 'Launching...' : 'Launch Chat'}
        onPress={handleLaunchChat}
        disabled={isLoading}
      />
    </View>
  );
}
```

## Platform Support

- ✅ iOS (Swift/Objective-C)
- ✅ Android (Kotlin)

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
