//
//  KMTableViewController.m
//  Demo
//
//  Created by Kylan McBride on 11/14/13.
//  Copyright (c) 2013 Kylan McBride. All rights reserved.
//

#import "KMTableViewController.h"
#import "UITableView+HighlightedSectionHeader.h"

static NSString * const kHeaderIdentifier = @"Header";
static NSString * const kCellIdentifier = @"Cell";

@implementation KMTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  UIColor *tableSectionHighlightColor = [UIColor colorWithWhite:0.97f alpha:1.0f];
  [self.tableView highlightSectionHeaderWithColor:tableSectionHighlightColor];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  // The header views have not been drawn until now, so trigger
  // a refresh that will reset their highlighted states.
  self.tableView.contentOffset = self.tableView.contentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@"Row %i", indexPath.row];

  return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return [NSString stringWithFormat:@"Section %i", section];
}

@end
