//
//  ViewController.m
//  UntrackingHeaderTable
//
//  Created by 石場清子 on 2019/11/17.
//  Copyright © 2019 石場清子. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation InitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self scrollViewDidScroll:self.tableView];
}


// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld - %ld", indexPath.section, indexPath.row];
    return cell;
}


// MARK: - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Header - %ld", section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Footer - %ld", section];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat sectionHeaderHeight = self.tableView.sectionHeaderHeight;
    CGFloat sectionFooterHeight = self.tableView.sectionFooterHeight;
    CGFloat bottomHeight = scrollView.contentSize.height - self.tableView.frame.size.height;

    if (offsetY <= sectionHeaderHeight && offsetY >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    } else if (bottomHeight-sectionFooterHeight > scrollView.contentOffset.y && offsetY >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    } else if (offsetY >= bottomHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    } else if (offsetY >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }
}

@end
