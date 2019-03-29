//
//  GitRepo.h
//  GitHub
//
//  Created by Safaa Khalaf on 3/29/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GitRepo : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *owner;
@property (nonatomic) NSString *avatar;
@property (nonatomic) NSUInteger starsCount;

@end

NS_ASSUME_NONNULL_END
