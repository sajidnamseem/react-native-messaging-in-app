//
//  MessagingModule.m
//  groupedynamite
//
//  Created by Sajid Naseem on 2025-06-15.
//  Copyright © 2025 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(MessagingModule, NSObject)

RCT_EXTERN_METHOD(launchChat:(NSDictionary *)config
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
