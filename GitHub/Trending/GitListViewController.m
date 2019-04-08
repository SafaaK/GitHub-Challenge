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
#import "LoadingCell.h"
#import "GitRepo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YBHud.h"


@interface GitListViewController ()
@end

@implementation GitListViewController
YBHud *hud;
NSMutableArray *gitRepos;
bool isLoading;

- (void)viewDidLoad {
    [super viewDidLoad];
    gitRepos = [[NSMutableArray alloc]init];
    
    self.pageNum = 1;
    isLoading = false;
    
    //to remove emty lines from table
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0;
    
    
    [self.emptyState.fetchButton addTarget:self action:@selector(fetchGitList) forControlEvents:UIControlEventTouchUpInside];
}


- (void)fetchGitList{
    //show the loader centered on first fetch only, load more loader for subsequent pages
    if(self.pageNum  == 1){
        [self showLoader];
    }
 
    isLoading = true;
    [[AppDelegate sharedAppDelegate].apiManager fetchGithubRepos:self.pageNum completion:^(NSArray * gitReposArray, NSString * statusMsg) {
        if(self.pageNum == 1){
          [self hideLoader];
        }
        
        isLoading = false;
        if(gitReposArray.count > 0){
            [gitRepos addObjectsFromArray:gitReposArray];
            [self.tableView reloadData];
        }
        else{
            //ERROR
            UIAlertController *errorAlert=   [UIAlertController
                                              alertControllerWithTitle:nil
                                              message:statusMsg
                                              preferredStyle: UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [errorAlert addAction:cancelAction];
            
            [self presentViewController:errorAlert animated:YES completion:nil];
         }
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
    [[self.view viewWithTag:10] removeFromSuperview];
    [[self.view viewWithTag:11] removeFromSuperview];
    
}

-(void)showLoader{
    //Initialization
    
    [self addBlurEffect];
    hud = [[YBHud alloc]initWithHudType:DGActivityIndicatorAnimationTypeLineScaleParty andText:@"Fetching Repos"];
   
    //Tint Color (Indicator Color)
    hud.tintColor = purple;
    
    //HUD Color
    hud.hudColor = [UIColor whiteColor];
    
    //Optional Dim Amount of HUD
    hud.dimAmount = 0.1;
    
    //Display HUD
    [hud showInView:self.view animated:YES];
    
}

-(void)hideLoader{
    [self removeBlurEffect];
    [hud dismissAnimated:YES];
}

#pragma-mark Helper
//Validate value is valid and != null
-(BOOL) isValidObject:(id)parameter{
    if (parameter == nil || (NSNull*)parameter == [NSNull null] || [parameter isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}


#pragma-mark Tableview

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [gitRepos count] - 1 && !isLoading ) {
        _pageNum++;
        [self fetchGitList];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [gitRepos count])
        return 70;
    
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [gitRepos count]) {
        static NSString *cellID = @"LoadingCell";
        LoadingCell *loadingCell = (LoadingCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (loadingCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"LoadingCell" owner:self options:nil];
            loadingCell = [nib objectAtIndex:0];
        }
        [loadingCell.loader startAnimating];
        return loadingCell;
        
    } else {
        static NSString *cellID = @"GitRepoCell";
        GitRepoCell *repoCell = (GitRepoCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
        if (repoCell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"GitRepoCell" owner:self options:nil];
            repoCell = [nib objectAtIndex:0];
        }
        GitRepo *repoObj = [gitRepos objectAtIndex:indexPath.row];
        if([self isValidObject:repoObj.name])
            repoCell.repoName.text = repoObj.name;
        
        if([self isValidObject:repoObj.desc])
            repoCell.repoDescription.text = repoObj.desc;
        
         if([self isValidObject:repoObj.owner])
             repoCell.ownerName.text = repoObj.owner;
        
        repoCell.startLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)repoObj.starsCount];
      
        if([self isValidObject:repoObj.avatar])
             [repoCell.avatarImg sd_setImageWithURL:[NSURL URLWithString:repoObj.avatar]
                     placeholderImage:[UIImage imageNamed:@"imgPlaceholder"]];
      
        return repoCell;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Add Empty State when there is no repos
    if(gitRepos.count == 0){
        self.tableView.backgroundView = self.emptyState;
        return gitRepos.count;
    }
    //remove the empty state and show table with fetched results
    else{
        self.tableView.backgroundView = nil;
        return gitRepos.count+1;
    }
 
  
}


@end
