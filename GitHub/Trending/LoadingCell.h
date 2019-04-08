//
//  LoadingCell.h
//  GitHub
//
//  Created by Safaa Khalaf on 4/8/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignConstants.h"
#import "YBHud.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoadingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet DGActivityIndicatorView *loader;

@end

NS_ASSUME_NONNULL_END
