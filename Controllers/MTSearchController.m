//
//  MTSearchController.m
//  MTSearchBar
//
//  Created by 王翔 on 2016/11/9.
//  Copyright © 2016年 WangXiangMT. All rights reserved.
//

#import "MTSearchController.h"
#import "MTSearchTextField.h"
#import "UIBarButtonItem+MTBarButtonItem.h"
#import "MTSearchCell.h"
#import "MTListViewController.h"
#import "MTDeleateView.h"

#define MAIN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define MAIN_WIDTH   [UIScreen mainScreen].bounds.size.width
//历史搜索记录的文件路径
#define SearchHistoryPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"hisDatas.data"]

@interface MTSearchController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *historyTableView;
    UITableView *searchTableView;
}

//搜索框
@property (nonatomic , strong) MTSearchTextField *textField;
//搜索的数据
@property (nonatomic , strong) NSMutableArray *dataArray;
//历史搜索数据
@property (nonatomic , strong) NSMutableArray *historyArray;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) MTSearchCell *cell;

@property (nonatomic , strong) MTDeleateView *deleateView;

@end

@implementation MTSearchController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //初始化导航条内容
    [self setNavigationItem];
    
    [self setUpUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(exchangeTableView)
                                                 name:nil
                                               object:nil];
}

-(void)setUpUI
{
    historyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WIDTH, MAIN_HEIGHT)];
    historyTableView.delegate = self;
    historyTableView.dataSource = self;
    historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:historyTableView];
    
    searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MAIN_WIDTH, MAIN_HEIGHT)];
    searchTableView.delegate = self;
    searchTableView.dataSource = self;
    searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:searchTableView];
    searchTableView.hidden = YES;

    
}

-(void)setNavigationItem
{
    MTSearchTextField *search = [[MTSearchTextField alloc] init];
    search.frame = CGRectMake(0, 0, MAIN_WIDTH*0.78, 27);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:search];
    search.delegate = self;
    self.textField = search;
    UIBarButtonItem *right = [UIBarButtonItem initWithTitle:@"取消" titleColor:[UIColor whiteColor] target:self action:@selector(backClick)];
    self.navigationItem.rightBarButtonItem = right;
    
}

//取消按钮
- (void)backClick
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击屏幕搜索框失去焦点
    [self.textField resignFirstResponder];
}
*/


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([tableView isEqual:historyTableView]) {
        
        return 30;
    }else {
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if ([tableView isEqual:historyTableView]) {
        
        _deleateView = [MTDeleateView view];
        _deleateView.frame = CGRectMake(0, 0, MAIN_WIDTH, 30);
        [_deleateView.clearBtn addTarget:self action:@selector(clearBtn) forControlEvents:UIControlEventTouchUpInside];
        
        if (_historyArray.count == 0) {
            
            _deleateView.historyLab.text = @"";
        }
        
        
        return _deleateView;

    } else {
        return  0;
    }
    
}

-(void)clearBtn
{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:nil message:@"确认删除全部历史记录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:SearchHistoryPath error:nil];
        [_historyArray removeAllObjects];
        
        [historyTableView reloadData];
    }];
    
    [alter addAction:cancel];
    [alter addAction:okAction];
    [self presentViewController:alter animated:YES completion:nil];

}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:historyTableView]) {
        
        return self.historyArray.count;
    } else {
        
        return 5;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if ([tableView isEqual:historyTableView]) {
        return 1;
    } else {
        return 1;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if ([tableView isEqual:historyTableView]) {
        
        _cell = [MTSearchCell historyCellWithTableView:tableView IndexPath:indexPath atNSMutableArr:self.historyArray];
        _cell.contentLab.text = self.historyArray[indexPath.row];
        return _cell;
    } else {
        
        static NSString *cellId = @"cellId";
        
        UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        if (!myCell) {
            
            myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            
            myCell.textLabel.text = @"测试数据";
        }
        
        return myCell;
    }
    
    
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        if (self.historyArray.count) {
            
            [_dataArray addObject:self.historyArray];
        }
        //
    }
    return _dataArray;
}

-(NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray = [NSMutableArray arrayWithContentsOfFile:SearchHistoryPath];
    
        if (_historyArray == nil) {
            
            _historyArray = [NSMutableArray arrayWithObjects:@"周杰伦",@"谢霆锋", nil];
            
        }
        
        
    }
    return _historyArray;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        
        for (NSString *text in self.historyArray) {
            
            if ([text isEqualToString:textField.text]) {
                return YES;
            }
        }
        
        [self.historyArray insertObject:textField.text atIndex:0];
        [self.historyArray writeToFile:SearchHistoryPath atomically:YES];
        [historyTableView reloadData];
        textField.text = @"";
        
        //跳转到下一个界面
        
        MTListViewController *listVc = [[MTListViewController alloc] init];
        listVc.searchTitle = textField.text;
        [self.navigationController pushViewController:listVc animated:YES];
        
        
    }
    
    return YES;
}

-(void)exchangeTableView
{
    if ([_textField.text length]>0) {
        
        historyTableView.hidden = YES;
        searchTableView.hidden = NO;
    } else {
        
        historyTableView.hidden = NO;
        searchTableView.hidden = YES;
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self]; //移除通知
}

@end
