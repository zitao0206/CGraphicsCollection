 //
//  CGHomeViewController.m
//  CGraphicsCollection
//
//  Created by Leon0206 on 04/12/2021.
//  Copyright (c) 2021 Leon0206. All rights reserved.
//

#import "CGHomeViewController.h"
#import "CommonKit.h"
#import "CGHomeTopCell.h"
#import "CGHomeMiddleCell.h"
#import "CGHomeBottomCell.h"

#define kTopCellHeight     150.0
#define kMiddleCellHeight  250.0
#define kSpaceBetweenCell  15.0

@interface CGHomeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CGHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
 
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.contentSize = CGSizeMake(kScreenWidth, self.tableView.height);
}

#pragma mark -- tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return kSpaceBetweenCell;
    }
    if (section == 1) {
        return kSpaceBetweenCell;
    }
    return 0;
}

 
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return kTopCellHeight;
    }
    if (indexPath.section == 1) {
        return kMiddleCellHeight;
    }
    if (indexPath.section == 2) {
        return self.tableView.height - kTopCellHeight - kMiddleCellHeight - kSpaceBetweenCell * 2;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor greenColor];
    return headView;
}

 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!contentCell) {
        contentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    contentCell.backgroundColor = [UIColor redColor];
    contentCell.accessoryType = UITableViewCellAccessoryNone;
    contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return contentCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor blackColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[CGHomeTopCell class] forCellReuseIdentifier:@"CGHomeTopCell"];
        [_tableView registerClass:[CGHomeMiddleCell class] forCellReuseIdentifier:@"CGHomeMidlleCell"];
        [_tableView registerClass:[CGHomeBottomCell class] forCellReuseIdentifier:@"CGHomeBottomCell"];
    }
    return _tableView;
}

@end
