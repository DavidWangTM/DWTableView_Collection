//
//  ViewController.h
//  DWTableView
//
//  Created by DavidWang on 15/8/19.
//  Copyright (c) 2015年 DavidWang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BOUNDS [[UIScreen mainScreen] bounds].size

@interface ViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

