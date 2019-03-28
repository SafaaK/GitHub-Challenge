//
//  EmptyState.h
//  GitHub
//
//  Created by Safaa Khalaf on 3/28/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface EmptyState : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;
@property (weak, nonatomic) IBOutlet UIButton *fetchButton;

@property (strong, nonatomic) IBOutlet UIView *view;

- (IBAction)fetchGitList:(id)sender;

@end

NS_ASSUME_NONNULL_END
