 //
//  CGHomeViewController.m
//  CGraphicsCollection
//
//  Created by Leon0206 on 04/12/2021.
//  Copyright (c) 2021 Leon0206. All rights reserved.
//

#import "CGHomeViewController.h"

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

#pragma mark -- tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *contentCell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!contentCell) {
        contentCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    contentCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return contentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    UIViewController *vc = nil;
    if (0 == index) {
        vc = [[CUIHallViewControlViewController alloc]init];
    }
    if (1 == index) {
        vc = [[CUIHallViewAnimationViewController alloc]init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    }
    return _tableView;
}

@end
