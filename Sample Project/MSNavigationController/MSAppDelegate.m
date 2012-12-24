//
//  MSAppDelegate.m
//  MSNavigationController
//
//  Created by Michał Śmiałko on 23.12.2012.
//  Copyright (c) 2012 MS. All rights reserved.
//

#import "MSAppDelegate.h"

#import "MSViewController.h"
#import "MSNavigationController.h"

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.viewController = [[MSViewController alloc] init];
    
    MSNavigationController *navController = [[MSNavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
