//
//  MTDeleateView.h
//  MTSearchBar
//
//  Created by 王翔 on 2016/11/9.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTDeleateView : UIView
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;
@property (weak, nonatomic) IBOutlet UILabel *historyLab;
+(instancetype)view;
@end
