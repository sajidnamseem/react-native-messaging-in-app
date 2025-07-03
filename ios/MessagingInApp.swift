//
//  MessagingModule.swift
//  groupedynamite
//
//  Created by Sajid Naseem on 2025-06-15.
//  Copyright © 2025 Facebook. All rights reserved.
//

import Foundation
import React
import SMIClientUI
import SMIClientCore
import SwiftUI

@objc(MessagingModule)
class MessagingModule: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc
    func launchChat(_ config: [String: Any],
                   resolver resolve: @escaping RCTPromiseResolveBlock,
                   rejecter reject: @escaping RCTPromiseRejectBlock) {
          let reactConfig = config

             // 🔁 Save the JS-passed config so hidden pre-chat fields work
            GlobalHiddenPreChatDelegate.shared.setConfig(config)
            // Create configuration from the config file or manual values
            guard let configPath = Bundle.main.path(forResource: "configFile", ofType: "json") else {
            // If config file doesn't exist, use manual configuration
            if let serviceAPI = config["serviceAPI"] as? String,  // Changed from "url" to "serviceAPI"
                let organizationId = config["organizationId"] as? String,
                let developerName = config["developerName"] as? String {
                let userVerificationRequired = config["userVerificationRequired"] as? Bool ?? false
            
                // Create configuration manually with correct parameter label
                let config = Configuration(
                    serviceAPI: URL(string: serviceAPI)!,  // Changed from url to serviceAPI
                    organizationId: organizationId,
                    developerName: developerName,
                    userVerificationRequired: userVerificationRequired
                )
                
                launchChatInterface(with: config,reactConfig: reactConfig, resolve: resolve, rejecter: reject)
            } else {
                reject("ERROR", "Invalid configuration", nil)
            }
            return
        }
        
        // Use config file if it exists
        let configURL = URL(fileURLWithPath: configPath)
        if let config = Configuration(url: configURL, userVerificationRequired: false) {
            launchChatInterface(with: config, reactConfig: reactConfig, resolve: resolve, rejecter: reject)
        } else {
            reject("ERROR", "Failed to create configuration", nil)
        }
    }
    
    private func launchChatInterface(with config: Configuration,
                                     reactConfig: [String: Any],

                                   resolve: @escaping RCTPromiseResolveBlock,
                                   rejecter reject: @escaping RCTPromiseRejectBlock) {
    
        DispatchQueue.main.async {
            // Create UI configuration with a new conversation ID
            // Note: For persistent conversations, use the same ID
            let conversationId = UUID()
            let uiConfig = UIConfiguration(
                configuration: config,
                conversationId: conversationId
            )
         
            uiConfig.conversationOptionsConfiguration = ConversationOptionsConfiguration(allowEndChat: true)

            // ✅ Create CoreClient and assign hidden pre-chat delegate
            let coreClient = CoreFactory.create(withConfig: uiConfig)
            coreClient.preChatDelegate = GlobalHiddenPreChatDelegate.shared

            let chatVC = ModalInterfaceViewController(uiConfig)
            chatVC.modalPresentationStyle = .fullScreen

            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(chatVC, animated: true)
                resolve(nil)
            } else {
                reject("ERROR", "Could not present chat interface", nil)
            }
        }
    }
}


final class GlobalHiddenPreChatDelegate: NSObject, HiddenPreChatDelegate {
    
    static let shared = GlobalHiddenPreChatDelegate()

    /// React config dictionary passed from JS
    private var reactConfig: [String: Any] = [:]

    private override init() {}

    /// Update from JS
    func setConfig(_ config: [String: Any]) {
        self.reactConfig = config
    }

    // Delegate method to populate hidden pre-chat fields
    func core(_ core: CoreClient,
              conversation: Conversation,
              didRequestPrechatValues hiddenPreChatFields: [HiddenPreChatField],
              completionHandler: HiddenPreChatValueCompletion) {

        let keysInOrder = ["language", "country", "brand", "chatMedium"]
       
        for (index, field) in hiddenPreChatFields.enumerated() {
          if index < keysInOrder.count {
              let key = keysInOrder[index]
              let value = reactConfig[key] as? String ?? ""
              field.value = value
          } else {
              print("Extra field at index \(index), no mapping")
          }
        }
        // ✅ Return updated fields to the SDK
        completionHandler(hiddenPreChatFields)
    }
  
}

 
