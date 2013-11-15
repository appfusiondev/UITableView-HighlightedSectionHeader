//
//  UITableView+HighlightedSectionHeader.h
//
//  Created by Kylan McBride on 11/14/13.
//  Copyright (c) 2013. All rights reserved.
//

@interface UITableView (HighlightedSectionHeader)

- (void)highlightSectionHeaderWithColor:(UIColor *)highlightColor;

@property (nonatomic, strong, readonly) UIColor *sectionHeaderHighlightedBackgroundColor;
@property (nonatomic, strong, readonly) UIColor *sectionHeaderBackgroundColor;

@end
