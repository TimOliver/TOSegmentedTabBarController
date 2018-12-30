//
//  AppDelegate.m
//  TOSegmentedTabBarControllerExample
//
//  Created by Tim Oliver on 30/12/18.
//  Copyright © 2018 Tim Oliver. All rights reserved.
//

#import "AppDelegate.h"
#import "TOSegmentedTabBarController.h"
#import "GroupedTableViewController.h"
#import "PlainTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    GroupedTableViewController *groupedController = [[GroupedTableViewController alloc] init];
    groupedController.title = @"Download";
    UINavigationController *firstController = [[UINavigationController alloc] initWithRootViewController:groupedController];
    firstController.navigationBar.prefersLargeTitles = YES;
    
    PlainTableViewController *plainController = [[PlainTableViewController alloc] init];
    plainController.title = @"Activity";
    UINavigationController *secondController = [[UINavigationController alloc] initWithRootViewController:plainController];
    secondController.navigationBar.prefersLargeTitles = YES;
    
    
    TOSegmentedTabBarController *segmentedController = [[TOSegmentedTabBarController alloc] initWithControllers:@[firstController, secondController]];
    segmentedController.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil]];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = segmentedController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
