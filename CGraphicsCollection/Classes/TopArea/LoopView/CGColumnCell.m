//
//  CGColumnCell.m
//  Pods
//
//  Created by lizitao on 2021/1/21.
//

#import "CGColumnCell.h"
 
@interface CGColumnCell()
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CGColumnCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        [_imageView stopAnimating];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    if (imageUrl.length <= 0) return;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.top = 0;
    self.imageView.left = 0;
}


@end
