//
//  MTSearchCell.m
//  MTSearchBar
//
//  Created by 王翔 on 2016/11/9.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import "MTSearchCell.h"

@interface MTSearchCell ()
#define SearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hisDatas.data"]

//记录自己哪个数据
@property (nonatomic, weak) NSIndexPath *indexPath;
//记录模型
@property (nonatomic, weak) NSMutableArray *hisDatas;

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation MTSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//删除按钮
- (IBAction)deletBtnAction:(UIButton *)sender {
    
    [self.hisDatas removeObjectAtIndex:self.indexPath.row];
    
    [self.hisDatas writeToFile:SearchHistoryPath atomically:YES];
    
    [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });

}

+ (instancetype)historyCellWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath atNSMutableArr:(NSMutableArray *)datas
{
    static NSString *identifier = @"MTSearchCell";
    MTSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
    }
    cell.tableView = tableView;
    cell.hisDatas = datas;
    cell.indexPath = indexPath;
    
    return cell;

}

@end
