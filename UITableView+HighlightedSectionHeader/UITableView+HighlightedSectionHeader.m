//
//  UITableView+HighlightedSectionHeader.m
//
//  Created by Kylan McBride on 11/14/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView+HighlightedSectionHeader.h"

static NSString * const kHighlightColor = @"HighlightColor";
static NSString * const kDefaultColor = @"DefaultColor";

@implementation UITableView (HighlightedSectionHeader)

- (void)highlightSectionHeaderWithColor:(UIColor *)highlightColor {
  if (!self.sectionHeaderHighlightedBackgroundColor) {
    self.sectionHeaderHighlightedBackgroundColor = highlightColor;
    self.sectionHeaderBackgroundColor = self.backgroundColor;

    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
  }
}

#pragma mark - Getters

- (UIColor *)sectionHeaderHighlightedBackgroundColor {
  return objc_getAssociatedObject(self, (__bridge const void *)(kHighlightColor));
}

- (UIColor *)sectionHeaderBackgroundColor {
  return objc_getAssociatedObject(self, (__bridge const void *)(kDefaultColor));
}

#pragma mark - Setters

- (void)setSectionHeaderHighlightedBackgroundColor:(UIColor *)highlightColor {
  [self willChangeValueForKey:@"highlightColor"];
  objc_setAssociatedObject(self, (__bridge const void *)(kHighlightColor), highlightColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self didChangeValueForKey:@"highlightColor"];
}

- (void)setSectionHeaderBackgroundColor:(UIColor *)defaultColor {
  [self willChangeValueForKey:@"defaultColor"];
  objc_setAssociatedObject(self, (__bridge const void *)(kDefaultColor), defaultColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  [self didChangeValueForKey:@"defaultColor"];
}

#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if ([keyPath isEqualToString:@"contentOffset"]) {
    CGPoint offset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
    [self scrollViewDidScroll:offset];
  }
}

- (void)scrollViewDidScroll:(CGPoint)contentOffset {
  NSArray *indexPaths = [self indexPathsForVisibleRows];

  if (indexPaths.count != 0) {
    CGFloat contentOffsetY = contentOffset.y;
    CGFloat contentInsetTop = self.contentInset.top;

    NSMutableSet *sections = [NSMutableSet setWithCapacity:indexPaths.count];

    for (NSIndexPath *indexPath in indexPaths) {
      NSNumber *section = [NSNumber numberWithInteger:indexPath.section];
      [sections addObject:section];
    }

    for (NSNumber *section in sections) {
      CGRect headerRect = [self rectForHeaderInSection:section.integerValue];
      BOOL shouldHighlight = (CGRectGetMinY(headerRect) <= (contentOffsetY + contentInsetTop));
      UIColor *backgroundColor = shouldHighlight ? self.sectionHeaderHighlightedBackgroundColor
                                                 : self.sectionHeaderBackgroundColor;

      UITableViewHeaderFooterView *header = [self headerViewForSection:section.integerValue];

      if (header.backgroundView) {
        header.backgroundView.backgroundColor = backgroundColor;
      } else {
        header.contentView.backgroundColor = backgroundColor;
      }
    }
  }
}

@end
