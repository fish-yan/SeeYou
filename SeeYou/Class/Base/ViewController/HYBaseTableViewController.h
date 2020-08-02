//
//  HYBaseTableViewController.h
//  youbaner
//
//  Created by Joseph Koh on 2018/4/17.
//  Copyright © 2018年 luzhongchang. All rights reserved.
//

#import "HYBaseViewController.h"

@interface HYBaseTableViewController : HYBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) UITableViewStyle style;

- (void)initialize;
- (void)setupSubviews;
- (void)setupSubviewsLayout;
- (void)bind;

@end
