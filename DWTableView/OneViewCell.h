//
//  OneViewCell.h
//  DWTableView
//
//  Created by DavidWang on 15/8/19.
//  Copyright (c) 2015年 DavidWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITableView *cell_tableView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@end
