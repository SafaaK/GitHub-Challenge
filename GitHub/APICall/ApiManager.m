//
//  ApiManager.m
//  GitHub
//
//  Created by Safaa Khalaf on 3/29/19.
//  Copyright © 2019 SafaaKh. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ApiManager.h"
#import "Reachability.h"
#import "GitRepo.h"

@implementation ApiManager

#define GitHubSearchURL @"https://api.github.com/search/repositories?q=created:>%@&sort=stars&order=desc&page=%d"

-(NSString *)lastMonthDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDate *date = [cal dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:[NSDate date] options:0];;
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}
 
-(void)fetchGithubRepos:(int)page completion:(CompletionBlock)completionBlock
{
    
    if(![self isInternetAvailable]){
        NSString *statusMsg = @"Internet connection failure.";
        completionBlock([[NSArray alloc]init], statusMsg);
    }
    else{
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        defaultConfigObject.allowsCellularAccess = YES;
        defaultConfigObject.timeoutIntervalForRequest = 30.0;
        defaultConfigObject.timeoutIntervalForResource = 30.0;
        NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:GitHubSearchURL,[self lastMonthDate],page] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
        NSLog(@"calling API: %@",url);
        NSURLSessionDataTask *dataTask=[defaultSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *statusMsg;
            
            if (error==nil) {
                NSError *err = nil;
                NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                if(jsonDic){
                    
                    NSMutableArray *reposArray = [[NSMutableArray alloc]init];
                    for(id repoDic in [jsonDic objectForKey:@"items"]){
                        NSString *name = [repoDic objectForKey:@"name"];
                        NSString *description = [repoDic objectForKey:@"description"];
                        NSString *avatar = [repoDic valueForKeyPath:@"owner.avatar_url"];
                        NSUInteger stars = [[repoDic valueForKey:@"stargazers_count"] integerValue];
                        NSString *owner = [repoDic valueForKeyPath:@"owner.login"];
                        
                        
                        GitRepo *git = [[GitRepo alloc]init];
                        git.name = name;
                        git.desc = description;
                        git.starsCount = stars;
                        git.avatar = avatar;
                        git.owner = owner;
                        [reposArray addObject:git];
                    }
                    statusMsg = @"Success";
                     
                    completionBlock(reposArray, statusMsg);
                }
                else{
                   completionBlock([[NSArray alloc]init], statusMsg);
                }
                
                
            }
            else{
                statusMsg = [error description];
                completionBlock([[NSArray alloc]init], statusMsg);
            }
            
        }];
         [dataTask resume];
    }
} 

-(bool) isInternetAvailable
{
    bool success = false;
    const char *host_name = [@"google.com" cStringUsingEncoding:NSASCIIStringEncoding];
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL,host_name);
    SCNetworkReachabilityFlags flags;
    success = SCNetworkReachabilityGetFlags(reachability, &flags);
    bool isAPIReachable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
    return isAPIReachable;
}

@end
