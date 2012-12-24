//
//  MSAppDelegate.h
//  MSNavigationController
//
//  Created by Michał Śmiałko on 23.12.2012.
//  Copyright (c) 2012 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSViewController;

@interface MSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MSViewController *viewController;

@end
