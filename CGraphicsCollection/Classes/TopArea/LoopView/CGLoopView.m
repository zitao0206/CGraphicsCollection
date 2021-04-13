//
//  CGLoopView.m
//  Pods
//
//  Created by Leon on 2021/1/21.
//

#import "CGLoopView.h"
#import "CGColumnCell.h"
#import "CGLoopPageControl.h"
#import "CGLoopItemModel.h"

#define MaxSections     3
@interface CGLoopView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <CGLoopItemModel *>*items;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CGLoopPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentLogPage;

@end

@implementation CGLoopView

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemHeight = frame.size.height;
        flowLayout.itemSize = CGSizeMake(frame.size.width, itemHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, itemHeight) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.layer.cornerRadius = 8.0;
        collectionView.clipsToBounds = YES;
        [self addSubview:collectionView];
        self.collectionView = collectionView;
        [self.collectionView registerClass:[CGColumnCell class] forCellWithReuseIdentifier:@"CGColumnCell"];

        CGLoopPageControl *pageControl = [[CGLoopPageControl alloc] init];
        pageControl.frame = CGRectMake(0, 0, frame.size.width, 30);
        pageControl.pageIndicatorTintColor = [UIColor blackColor];
        pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        pageControl.enabled = NO;
        [self addSubview:pageControl];
        _pageControl = pageControl;
        _currentLogPage = -1;
        [self addTestData];
    }
    return self;
}

- (void)addTestData
{
    NSMutableArray *items = [NSMutableArray array];
    {
        CGLoopItemModel *item = [CGLoopItemModel new];
        item.jumpType = CGWebType;
        item.jumpContent = @"https://www.baidu.com/";
        item.icon = @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3865336888,1317295171&fm=26&gp=0.jpg";
        [items addObject:item];
    }
    {
        CGLoopItemModel *item = [CGLoopItemModel new];
        item.jumpType = CGWebType;
        item.jumpContent = @"https://www.baidu.com/";
        item.icon = @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3865336888,1317295171&fm=26&gp=0.jpg";
        [items addObject:item];
    }
    {
        CGLoopItemModel *item = [CGLoopItemModel new];
        item.jumpType = CGWebType;
        item.jumpContent = @"https://www.baidu.com/";
        item.icon = @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3865336888,1317295171&fm=26&gp=0.jpg";
        [items addObject:item];
    }
    self.items = items;
    [self refreshDataWith:items];
}

- (void)refreshDataWith:(id)obj
{
    if ([obj isKindOfClass:[NSArray class]]) {
        self.pageControl.numberOfPages = self.items.count;
        self.pageControl.hidden = NO;
        [self addTimer];
        [self.collectionView reloadData];
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.top = 0;
    self.collectionView.left = 0;
    self.pageControl.centerX = self.collectionView.centerX;
    self.pageControl.top = self.collectionView.bottom - 30;
}

#pragma mark -- 添加定时器、删除定时器

- (void)addTimer
{
    if (self.timer) {
        [self removeTimer];
    }
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer timerWithTimeInterval:3.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf nextpage];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextpage
{
    if (self.collectionView.numberOfSections <= 1) return;
    NSInteger section = 0;
    if (self.collectionView.numberOfSections == 2) {
        section = 0;
    } else {
        section = 1; //MaxSections / 2
    }
    NSIndexPath *curIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *curIndexPathReset = [NSIndexPath indexPathForItem:curIndexPath.item inSection:section];
    
    if ([self checkValidIndexPath:curIndexPathReset]) {
        [self.collectionView scrollToItemAtIndexPath:curIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    NSInteger nextItem = curIndexPathReset.item + 1;
    NSInteger nextSection = curIndexPathReset.section;
    if (nextItem == self.items.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    if ([self checkValidIndexPath:nextIndexPath]) {
        [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}

- (BOOL)checkValidIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row < self.items.count) && (indexPath.section < self.collectionView.numberOfSections)) {
        return YES;
    }
    return NO;
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.items.count == 1) {
        return 1;
    }
    return MaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGColumnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGColumnCell" forIndexPath:indexPath];
    if(!cell) {
        cell = [[CGColumnCell alloc] init];
    }
    CGLoopItemModel *item = (CGLoopItemModel *)[self.items objectAtIndex:indexPath.row];
    if ([item.icon isKindOfClass:[NSString class]] && item.icon.length > 0) {
        cell.imageUrl = item.icon;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x/scrollView.frame.size.width)%self.items.count;
    if (self.pageControl.currentPage != page) {
        self.pageControl.currentPage = page;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self addTimer];
    });
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat kWidth = self.collectionView.width;
    if (kWidth > 0) {
        NSInteger offset = scrollView.contentOffset.x/kWidth;
        if (offset == 0) {
            scrollView.contentOffset = CGPointMake(self.items.count * kWidth, 0);
        }
        if (offset == (self.items.count * MaxSections - 1)) {
            scrollView.contentOffset = CGPointMake((self.items.count * (MaxSections / 2) - 1) * kWidth, 0);
        }
    }
}

@end

