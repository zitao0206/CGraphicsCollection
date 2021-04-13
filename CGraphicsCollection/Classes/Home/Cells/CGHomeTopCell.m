//
//  CGHomeTopCell.m
//  Pods
//
//  Created by lizitao on 2021/1/21.
//
#import "CGHomeTopCell.h"
#import "CGLoopView.h"
 
@interface CGHomeTopCell ()
@property (nonatomic, strong) CGLoopView *loopView;
@end

@implementation CGHomeTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.loopView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.loopView.frame = self.contentView.bounds;
    self.loopView.left = 10;
    self.loopView.top = 0;
    
}

- (CGLoopView *)loopView
{
    if (!_loopView) {
        _loopView = [[CGLoopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, 150)];
        _loopView.layer.cornerRadius = 8.0;
    }
    return _loopView;
}


@end

