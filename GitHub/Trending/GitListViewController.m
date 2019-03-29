//
//  GitListViewController.m
//  GitHub
//
//  Created by Safaa Khalaf on 3/28/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//

#import "GitListViewController.h"
#import "AppDelegate.h"
#import "GitRepoCell.h"
#import "GitRepo.h"

@interface GitListViewController ()

@end

@implementation GitListViewController
NSArray *gitRepos;

- (void)viewDidLoad {
    [super viewDidLoad];
    gitRepos = [[NSArray alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.tableView.backgroundView = self.emptyState;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    
    [self.emptyState.fetchButton addTarget:self action:@selector(fetchGitList) forControlEvents:UIControlEventTouchUpInside];
}


- (void)fetchGitList{
    [[AppDelegate sharedAppDelegate].apiManager fetchGitHubSearches:^(NSArray * gitReposArray, NSString * statusMsg) {
//        NSLog(@"gitRepos: %@",gitReposArray);
//        NSLog(@"statusMsg: %@",statusMsg);
        gitRepos = gitReposArray;
        [self.tableView reloadData];
    }];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableID = @"GitRepoCell";
    GitRepoCell *repoCell = (GitRepoCell *)[tableView dequeueReusableCellWithIdentifier:tableID];
    if (repoCell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GitRepoCell" owner:self options:nil];
        repoCell = [nib objectAtIndex:0];
    }
    GitRepo *repoObj = [gitRepos objectAtIndex:indexPath.row];
    repoCell.repoName.text = repoObj.name;
    repoCell.repoDescription.text = repoObj.desc;
    repoCell.ownerName.text = repoObj.owner;
    repoCell.startLabel.text = [NSString stringWithFormat:@"%d",repoObj.starsCount];
    return repoCell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return gitRepos.count;
}


@end
