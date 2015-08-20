//
//  ViewController.m
//  DWTableView
//
//  Created by DavidWang on 15/8/19.
//  Copyright (c) 2015年 DavidWang. All rights reserved.
//

#import "ViewController.h"
#import "OneViewCell.h"
#import "OneView.h"
#import "ViewModel.h"
#import "GridCell.h"

@interface ViewController (){
    NSMutableArray *data;
    NSInteger tsection;
    NSInteger trow;
    UICollectionView *collectionview;
}

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tsection = -1;
    trow = -1;
    data = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        NSMutableArray *mdata = [NSMutableArray new];
        for (int j = 0; j < i+1; j++) {
            ViewModel *model = [ViewModel new];
            model.is_open = NO;
            [mdata addObject:model];
        }
        [data addObject:mdata];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Hard coded here for demo purpose
    return data.count;
}

//tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray *mdata = [data objectAtIndex:section];
    return mdata.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *mdata = [data objectAtIndex:indexPath.section];
    ViewModel *model = [mdata objectAtIndex:indexPath.row];
    if (model.is_open) {
        CGFloat height = ((BOUNDS.width - 103 - 8*3)/2 ) *5 *0.75+ (8*4) + 40;
        if ((mdata.count - 1) == indexPath.row) {
            height += 56;
        }
        return height;
    }
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"OneViewCell";
    OneViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.collectionView.delegate = self;
    cell.collectionView.dataSource = self;
    [cell.collectionView reloadData];
    NSMutableArray *mdata = [data objectAtIndex:indexPath.section];
    ViewModel *model = [mdata objectAtIndex:indexPath.row];
    if (model.is_open) {
        if ((mdata.count - 1) == indexPath.row) {
            cell.showBtn.hidden = NO;
            cell.collectionView.frame = CGRectMake(cell.collectionView.frame.origin.x, cell.collectionView.frame.origin.y, cell.collectionView.frame.size.width, cell.frame.size.height - 40);
        }else{
            cell.showBtn.hidden = YES;
        }
    }else{
        cell.showBtn.hidden = YES;
    }
    return cell;
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    OneView *headview = [[[NSBundle mainBundle] loadNibNamed:@"OneView" owner:self options:nil] firstObject];
    headview.frame = CGRectMake(0, 0, headview.frame.size.width, headview.frame.size.height);
    return headview;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tsection != -1 && trow != -1) {
        [self ChangeModel];
        if (tsection == indexPath.section && trow == indexPath.row) {
            tsection = -1;
            trow = -1;
            [_tableView reloadData];
            return;
        }
    }
    tsection = indexPath.section;
    trow = indexPath.row;
    [self ChangeModel];
    [_tableView reloadData];
    
    OneViewCell *cell = (OneViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell.collectionView reloadData];
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:trow inSection:tsection];
    [_tableView scrollToRowAtIndexPath:scrollIndexPath
                      atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

-(void)ChangeModel{
    NSMutableArray *mdata = [data objectAtIndex:tsection];
    ViewModel *model = [mdata objectAtIndex:trow];
    model.is_open = !model.is_open;
    [mdata replaceObjectAtIndex:trow withObject:model];
    [data replaceObjectAtIndex:tsection withObject:mdata];
}


//网格列表

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (BOUNDS.width - 103 - 8*3)/2;
    return CGSizeMake(width, width*0.75);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCell" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
// 选中某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

@end
