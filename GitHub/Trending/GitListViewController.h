//
//  GitListViewController.h
//  GitHub
//
//  Created by Safaa Khalaf on 3/28/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmptyState.h"

@interface GitListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet EmptyState *emptyState;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) int pageNum;

@end

