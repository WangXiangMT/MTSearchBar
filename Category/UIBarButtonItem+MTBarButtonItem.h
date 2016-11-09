//
//  UIBarButtonItem+MTBarButtonItem.h
//  MTSearchBar
//
//  Created by 王翔 on 2016/11/9.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MTBarButtonItem)

//带图片
+ (UIBarButtonItem *)initWithNormalImage:(NSString *)image target:(id)target action:(SEL)action width:(CGFloat)width height:(CGFloat)height;

//带文字
+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action;



@end
