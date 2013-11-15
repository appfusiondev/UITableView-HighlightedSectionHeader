### UITableView+HighlightedSectionHeader ###

A simple category that aims to emulate the UITableView section headers found in Music, Photos, Game Center, etc. for iOS 7.

----

#### Usage ####

In your controller's `viewDidLoad` method, add the observer to your table view.
```
- (void)viewDidLoad {
  [super viewDidLoad];
 
  // Your viewDidLoad implementation

  UIColor *highlightedBackgroundColor = [UIColor lightGrayColor];
  [tableView highlightSectionHeaderWithColor:highlightedBackgroundColor];
}
```

Depending on the metrics on your table view, you may need to trigger a refresh to reset the header background colors.
```
- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
 
  // Your viewDidAppear implementation
 
  self.tableView.contentOffset = self.tableView.contentOffset;
}
```

----

#### Example ####

![Demo](http://f.cl.ly/items/1T0p1b1n2z3X0w0P3I2j/demo.gif)

----

#### TODO ####

* Replace backgroundView with toolbar to achieve live blur effect of underlying content
