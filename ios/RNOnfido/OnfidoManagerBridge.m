//
//  OnfidoManagerBridge.m
//  RNOnfido
//
//  Created by Mark Vayngrib on 12/5/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(OnfidoManager, NSObject)

RCT_EXTERN_METHOD(setAPIToken:(nonnull NSString *)apiToken
                  callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(createFlow:(nonnull NSString *)apiKey
                  captureOptions:(NSArray*)captureOptions
                  createOptions:(NSDictionary<String, AnyObject>*)createOptions
                  callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(listApplicants:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(getApplicant:(nonnull NSString *)uuid
                      callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(createApplicant:(nonnull NSDictionary*) attributes
                         callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(listChecks:(nonnull NSString*)applicantId
                    callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(getCheck:(nonnull NSString*)applicantId
                 checkUuid:(nonnull NSString*)
                  callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(createCheck:(nonnull NSString*)applicantId
                   attributes: (nonnull NSDictionary*) attributes
                     callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(uploadDocument:(nonnull NSString*)applicantId
                         doctype: (nonnull NSString*)
                         fileURL: (nonnull NSURL*)
                        validate: bool
                        callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(uploadLivePhoto:(nonnull NSString*)applicantId
                              url:(nonnull NSURL*)
                         callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(getReport:(nonnull NSString*)checkId
                   reportId:(nonnull NSString*)
                   callback:(nonnull RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(listReports:(nonnull NSString*)checkId
                     callback:(nonnull RCTResponseSenderBlock) callback)

@end
