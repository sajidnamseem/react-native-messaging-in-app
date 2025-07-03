package com.messaginginapp

import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule
import com.salesforce.android.smi.core.*
import com.salesforce.android.smi.ui.*
import android.app.Activity
import android.content.Context
import java.util.UUID
import java.net.URL
import android.util.Log

class MessagingInAppModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "MessagingModule"
    }

    @ReactMethod
    fun launchChat(config: ReadableMap, promise: Promise) {
        try {
            val activity = currentActivity
            if (activity == null) {
                promise.reject("ERROR", "Activity not available")
                return
            }

            // Extract configuration parameters
            val serviceAPI = config.getString("serviceAPI")
            val organizationId = config.getString("organizationId")
            val developerName = config.getString("developerName")
            val userVerificationRequired = config.getBoolean("userVerificationRequired") ?: false

            if (serviceAPI == null || organizationId == null || developerName == null) {
                promise.reject("ERROR", "Missing required configuration parameters")
                return
            }

            // Create Core configuration
            val url = URL(serviceAPI)
            val coreConfig = CoreConfiguration(url, organizationId, developerName)

            // Generate conversation ID (use consistent ID for persistent conversations)
            val conversationID = UUID.randomUUID()

            // Create a core client from the config
            val coreClient = CoreClient.Factory.create(reactApplicationContext, coreConfig)

            // Register hidden pre-chat values provider
            coreClient.registerHiddenPreChatValuesProvider { input ->
                // Iterate through all the pre-chat fields
                input.forEach { field ->
                    // Specify the value for each field mapping
                    when (field.name) {
                        "f_Language" -> field.userInput = config.getString("language") ?: ""
                        "Chat_Medium" -> field.userInput = config.getString("chatMedium") ?: ""
                        "f_BrandName" -> field.userInput = config.getString("brand") ?: ""
                        "f_Country" -> field.userInput = config.getString("country") ?: ""
                    }
                }

                // Return the same list, but with updated values set
                input
            }

            // Create UI configuration
            val uiConfig = UIConfiguration(coreConfig, conversationID)

            // Create UIClient and open conversation
            val uiClient = UIClient.Factory.create(uiConfig)

            uiClient.openConversationActivity(activity)

            promise.resolve(true)

        } catch (e: Exception) {
            promise.reject("ERROR", e.message)
        }
    }

    @ReactMethod
    fun addListener(eventName: String) {
        // Required for RN built in Event Emitter
    }

    @ReactMethod
    fun removeListeners(count: Int) {
        // Required for RN built in Event Emitter
    }
}
