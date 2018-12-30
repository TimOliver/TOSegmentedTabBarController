//
//  GroupedTableViewController.m
//  TOSegmentedSplitViewControllerExample
//
//  Created by Tim Oliver on 30/12/18.
//  Copyright © 2018 Tim Oliver. All rights reserved.
//

#import "GroupedTableViewController.h"

@interface GroupedTableViewController ()

@end

@implementation GroupedTableViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Ipsum"
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:nil
                                                                                action:nil];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 5;
        case 1: return 3;
        case 2: return 4;
        case 3: return 1;
        case 4: return 2;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", (long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GroupedTableViewController *tableController = [[GroupedTableViewController alloc] init];
    tableController.title = @"Child Controller";
    [self.navigationController pushViewController:tableController animated:YES];
}

@end
