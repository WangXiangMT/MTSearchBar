//
//  MTDeleateView.m
//  MTSearchBar
//
//  Created by 王翔 on 2016/11/9.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import "MTDeleateView.h"

@implementation MTDeleateView

+(instancetype)view
{
    return [[[NSBundle mainBundle] loadNibNamed:@"MTDeleateView" owner:nil options:nil] lastObject];
}

@end
