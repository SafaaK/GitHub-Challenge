//
//  LoadingCell.m
//  GitHub
//
//  Created by Safaa Khalaf on 4/8/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import "LoadingCell.h"

@implementation LoadingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     
    self.loader.type = DGActivityIndicatorAnimationTypeBallPulse;
    self.loader.tintColor = purple;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
