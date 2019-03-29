//
//  GitRepoCell.m
//  GitHub
//
//  Created by Safaa Khalaf on 3/29/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import "GitRepoCell.h"
#import "DesignConstants.h"

@implementation GitRepoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.repoName.textColor = BlackColor;
    self.repoName.font = [UIFont fontWithName:mediumFont size:regularSize];
    
    self.repoDescription.textColor = MidGreyColor;
    self.repoDescription.font = [UIFont fontWithName:regularFont size:regularSize];
    
    self.ownerName.textColor = BlackColor;
    self.ownerName.font = [UIFont fontWithName:lightFont size:regularSize];
    
    self.startLabel.textColor = BlackColor;
    self.startLabel.font = [UIFont fontWithName:lightFont size:regularSize];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
