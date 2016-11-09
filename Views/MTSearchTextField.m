//
//  MTSearchTextField.m
//  MTSearchBar
//
//  Created by 王翔 on 2016/11/9.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import "MTSearchTextField.h"

@implementation MTSearchTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = @"输入您要搜索的内容";
        self.font = [UIFont systemFontOfSize:14];
        
        UIImage *image = [UIImage imageNamed:@"GroupCell"];
        self.background = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 3;
        
        //设置文边框左边专属View
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.bounds = CGRectMake(0, 0, 25, 25);
        leftView.contentMode = UIViewContentModeCenter;
        leftView.image = [UIImage imageNamed:@"searchm"];
        
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return self;
}


@end
