import React, { useState } from 'react';
import { Text, View, StyleSheet, TouchableOpacity, Alert } from 'react-native';
import { launchChat } from 'react-native-messaging-in-app';
import type { MessagingConfig } from 'react-native-messaging-in-app';

export default function App() {
  const [isLoading, setIsLoading] = useState(false);

  const handleLaunchChat = async () => {
    setIsLoading(true);
    try {
      const config: MessagingConfig = {
        serviceAPI: 'https://your-service-api.com', // Replace with your actual service API
        organizationId: 'your-org-id', // Replace with your actual organization ID
        developerName: 'your-developer-name', // Replace with your actual developer name
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
    <View style={styles.container}>
      <Text style={styles.title}>React Native Messaging In-App</Text>
      <Text style={styles.subtitle}>Salesforce Messaging Demo</Text>

      <TouchableOpacity
        style={[styles.button, isLoading && styles.buttonDisabled]}
        onPress={handleLaunchChat}
        disabled={isLoading}
      >
        <Text style={styles.buttonText}>
          {isLoading ? 'Launching...' : 'Launch Chat'}
        </Text>
      </TouchableOpacity>

      <Text style={styles.note}>
        Note: Update the configuration with your actual Salesforce credentials
      </Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 40,
    textAlign: 'center',
  },
  button: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 30,
    paddingVertical: 15,
    borderRadius: 8,
    marginBottom: 20,
  },
  buttonDisabled: {
    backgroundColor: '#ccc',
  },
  buttonText: {
    color: 'white',
    fontSize: 16,
    fontWeight: '600',
  },
  note: {
    fontSize: 12,
    color: '#999',
    textAlign: 'center',
    lineHeight: 18,
  },
});
