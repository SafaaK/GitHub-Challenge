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
#import <SDWebImage/UIImageView+WebCache.h>
#import "YBHud.h"

@interface GitListViewController ()
@end

@implementation GitListViewController
YBHud *hud;
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
    [self showLoader];
    [[AppDelegate sharedAppDelegate].apiManager fetchGitHubSearches:^(NSArray * gitReposArray, NSString * statusMsg) {
        [self hideLoader];
//        NSLog(@"gitRepos: %@",gitReposArray);
//        NSLog(@"statusMsg: %@",statusMsg);
        gitRepos = gitReposArray;
        [self.tableView reloadData];
    }];
    
    
}

#pragma-mark Loader
-(void)addBlurEffect{
    [self removeBlurEffect];
    if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.tag = 10;
        
        
        // create vibrancy effect
        UIVibrancyEffect *vibrancy = [UIVibrancyEffect effectForBlurEffect:blurEffect];
        UIVisualEffectView *vibrantView = [[UIVisualEffectView alloc]initWithEffect:vibrancy];
        vibrantView.frame = self.view.bounds;
        vibrantView.tag = 11;
        
        [self.view addSubview:blurEffectView];
        [self.view addSubview:vibrantView];
    }
    else {
        self.view.backgroundColor = [UIColor blackColor];
    }
}

-(void)removeBlurEffect{
    for(UIView *sub in self.view.subviews){
        if(sub.tag == 11 || sub.tag == 10){
            [sub removeFromSuperview];
        }
    }
    
}

-(void)hideLoader{
    [self removeBlurEffect];
    [hud dismissAnimated:YES];
}

-(void)showLoader{
    //Initialization
    
    [self addBlurEffect];
    hud = [[YBHud alloc]initWithHudType:DGActivityIndicatorAnimationTypeBallZigZagDeflect andText:@"Fetching Repos"];
   
    
    //Tint Color (Indicator Color)
    hud.tintColor = purple;
    
    //HUD Color
    hud.hudColor = [UIColor whiteColor];
    
    //Optional User Interaction
    //hud.UserInteractionDisabled = YES; (User can interact with background views while HUD is displayed)
     
    //Optional Dim Amount of HUD
    hud.dimAmount = 0.1;
    
    //Display HUD
    [hud showInView:self.view animated:YES];
    
}


#pragma-mark Tableview
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
    repoCell.startLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)repoObj.starsCount];
    [repoCell.avatarImg sd_setImageWithURL:[NSURL URLWithString:repoObj.avatar]
                 placeholderImage:[UIImage imageNamed:@"imgPlaceholder"]];
    return repoCell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(gitRepos.count == 0){
         [self.emptyState setHidden:false];
    }
    return gitRepos.count;
}


@end
