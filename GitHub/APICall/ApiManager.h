//
//  ApiManager.h
//  GitHub
//
//  Created by Safaa Khalaf on 3/29/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApiManager : NSObject

typedef void (^CompletionBlock)(NSArray *, NSString *);

-(void)fetchGitHubSearches:(CompletionBlock)completionHandler;

-(bool) isInternetAvailable;
-(bool) isAPIReachable;



@end

NS_ASSUME_NONNULL_END
