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
    
    self.emptyLabel.textColor = MidGreyColor;
    self.emptyLabel.font = [UIFont fontWithName:regularFont size:regularSize];
    self.emptyLabel.text = @"No List Found";
    
    self.fetchButton.layer.backgroundColor = BlueColor.CGColor;
    [self.fetchButton setTitle:@"Fetch List" forState:UIControlStateNormal];
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


- (IBAction)getchGitList:(id)sender {
}
- (IBAction)fetchGitList:(id)sender {
}
@end
