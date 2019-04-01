//
//  EmptyState.m
//  GitHub
//
//  Created by Safaa Khalaf on 3/28/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import "EmptyState.h"
#import "DesignConstants.h"

@implementation EmptyState

-(void)loadHeader{
    [[NSBundle mainBundle] loadNibNamed:@"EmptyState" owner:self options:nil];
    
    self.titleLabel.textColor = BlackColor;
    self.titleLabel.font = [UIFont fontWithName:regularFont size:largeSize];
    self.titleLabel.text = @"No Available Results";
    
    
    self.subtitleLabel.textColor = MidGreyColor;
    self.subtitleLabel.font = [UIFont fontWithName:regularFont size:regularSize];
    self.subtitleLabel.text = @"List the most starred Github repos that were created in the last 30 days. ";
    
    
    self.fetchButton.layer.backgroundColor = purple.CGColor;
    [self.fetchButton setTitle:@"Fetch Trending Repos" forState:UIControlStateNormal];
    self.fetchButton.tintColor = [UIColor whiteColor];
    
    self.view.frame = self.bounds;
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    
    [self addSubview:self.view];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self loadHeader];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self loadHeader];
    }
    return self;
}


@end
