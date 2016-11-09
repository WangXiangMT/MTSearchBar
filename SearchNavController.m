
//
//  SearchNavController.m
//  MTSearchBar
//
//  Created by 王翔 on 2016/11/9.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import "SearchNavController.h"
#define navColor [UIColor colorWithRed:0.143 green:0.498 blue:0.935 alpha:0.900]
@interface SearchNavController ()

@end

@implementation SearchNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //字体颜色 大小 字体 什么都可以
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //导航栏背景色
    self.navigationBar.barTintColor = navColor;
    
    //导航栏item的颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
