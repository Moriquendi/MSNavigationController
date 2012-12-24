//
//  MSViewController.h
//  MSNavigationController
//
//  Created by Michał Śmiałko on 23.12.2012.
//  Copyright (c) 2012 MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end
