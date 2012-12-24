//
//  MSViewController.m
//  MSNavigationController
//
//  Created by Michał Śmiałko on 23.12.2012.
//  Copyright (c) 2012 MS. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@end

@implementation MSViewController

#pragma mark - UIViewController

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStylePlain];
    self.view = self.tableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Menu";
    
    // Navigation bar title appearance
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor blackColor],
                        UITextAttributeTextShadowOffset : [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                                    UITextAttributeFont : [UIFont fontWithName:@"HelveticaNeue" size:20]}];
    
    // Table view
    self.tableView.backgroundColor = [UIColor colorWithRed:200./255.
                                                green:200./255.
                                                 blue:200./255.
                                                alpha:1.0];
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %i", indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
