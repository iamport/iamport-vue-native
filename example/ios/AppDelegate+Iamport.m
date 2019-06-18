//
//  AppDelegate+Iamport.m
//  example
//
//  Created by deedee on 17/06/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "AppDelegate+Iamport.h"
#import <React/RCTLinkingManager.h>

@implementation AppDelegate (example)

- (BOOL)application:(UIApplication *)application
openURL:(NSURL *)url
options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
  return [RCTLinkingManager application:application openURL:url options:options];
}

@end
