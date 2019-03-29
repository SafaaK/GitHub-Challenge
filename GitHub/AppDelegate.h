//
//  AppDelegate.h
//  GitHub
//
//  Created by Safaa Khalaf on 3/28/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiManager.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedAppDelegate;
@property (strong, nonatomic) ApiManager *apiManager;

@end

