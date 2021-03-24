//
//  MMCycleView.m
//  MMCycleViewDemo
//
//  Created by Max on 2021/3/19.
//

#import "MMCycleView.h"
#import "MMCycleViewCell.h"
#import <SDWebImage.h>

@interface MMCycleView()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) NSMutableArray *MMImageArray;    ///< 存储显示图片数组

@property(nonatomic, assign) NSInteger MMTotalImageCount;    ///< 单次总轮播次数(轮播数量*100)

@property(nonatomic, strong) NSTimer *MMTimer;

@property(nonatomic, strong) UICollectionView *MMCollectionView;

@property(nonatomic, strong) UICollectionViewFlowLayout *MMFlowLayout;

@property (nonatomic, strong) UIPageControl *MMPage;

@end

static NSString *CellID = @"CellID";

@implementation MMCycleView

#pragma mark - Public Method
+ (instancetype)creatMMViewWithFrame:(CGRect)frame localArray:(NSArray *)localArray{
	MMCycleView *cycleView = [[MMCycleView alloc] initWithFrame:frame];
	if (!localArray.count) {
		return cycleView;
	}
	cycleView.localImgArr = (NSMutableArray *)localArray;
	return cycleView;
}

+ (instancetype)creatMMViewWithFrame:(CGRect)frame networkArray:(NSArray *)networkArray placeHolderImg:(UIImage *)placeHolderImg{
	MMCycleView *cycleView = [[MMCycleView alloc] initWithFrame:frame];
	cycleView.placeHolderImg = placeHolderImg;
	if (!networkArray.count) {
		return cycleView;
	}
	cycleView.networkImgArr = (NSMutableArray *)networkArray;
	return cycleView;
}

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self initialize];
	}
	return self;
}

- (void)initialize{
	_timeInterval = 2.0f;
	
	[self addSubview:self.MMCollectionView];
}

- (void)layoutSubviews{
	[super layoutSubviews];
	
	//设置初始显示位置
	if (self.MMCollectionView.contentOffset.x == 0 &&  self.MMTotalImageCount) {
		[self.MMCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.MMTotalImageCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
	}
	self.MMPage.frame = CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40);
}

- (void)dealloc{
	[_MMTimer invalidate];
	_MMTimer = nil;
}

- (void)addMyTimer{
	
	if (self.localImgArr.count == 1 || self.networkImgArr.count == 1) {
		return;
	}
	
	self.MMTimer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:_MMTimer forMode:NSRunLoopCommonModes];
}

- (void)removeMyTimer{
	[self.MMTimer invalidate];
	self.MMTimer = nil;
}

- (void)nextImage{
	if (!self.MMImageArray.count) {
		return;
	}
	
	NSInteger currentPage = self.MMCollectionView.contentOffset.x / self.MMFlowLayout.itemSize.width;
	NSInteger targetPage = currentPage + 1;
	if (targetPage == self.MMTotalImageCount) {
		targetPage = self.MMTotalImageCount * 0.5;
		
		[self.MMCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:false];
	}
	[self.MMCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetPage inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:true];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	return self.MMTotalImageCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	MMCycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
	NSInteger index = indexPath.item % self.MMImageArray.count;
	
	id obj = self.MMImageArray[index];
	if ([obj isKindOfClass:[UIImage class]]) {
		cell.imageView.image = (UIImage *)obj;
	}
	if ([obj isKindOfClass:[NSURL class]]) {
		[cell.imageView sd_setImageWithURL:(NSURL *)obj placeholderImage:self.placeHolderImg];
	}
	
	return cell;
}

#pragma mark ----ScrollView 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	int page = (int) (scrollView.contentOffset.x / self.MMCollectionView.frame.size.width + 0.5) % self.MMImageArray.count;
	self.MMPage.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
	[self removeMyTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[self addMyTimer];
}

#pragma mark - setter
- (void)setPlaceHolderImg:(UIImage *)placeHolderImg{
	_placeHolderImg = placeHolderImg;
}

- (void)setLocalImgArr:(NSMutableArray *)localImgArr{
	_localImgArr = localImgArr;
	
	NSMutableArray *locationImages = [NSMutableArray arrayWithCapacity:localImgArr.count];
	for (NSInteger i=0; i<localImgArr.count; i++) {
		UIImage *image = [UIImage imageNamed:localImgArr[i]];
		[locationImages addObject:image];
	}
	self.MMImageArray = locationImages;
}

- (void)setNetworkImgArr:(NSMutableArray *)networkImgArr{
	_networkImgArr = networkImgArr;
	
	NSMutableArray *netWorkImages = [NSMutableArray arrayWithCapacity:networkImgArr.count];
	for (NSInteger i = 0; i<networkImgArr.count; i++) {
		
		if ([networkImgArr[i] isKindOfClass:[NSString class]]) {
			NSURL *urlImg = [NSURL URLWithString:networkImgArr[i]];
			[netWorkImages addObject:urlImg];
		} else if ([networkImgArr[i] isKindOfClass:[NSURL class]]) {
			[netWorkImages addObject:networkImgArr[i]];
		}
	}
	self.MMImageArray = netWorkImages;
}

- (void)setMMImageArray:(NSMutableArray *)MMImageArray{
	_MMImageArray = MMImageArray;
		if (MMImageArray.count > 1) {
		[self addMyTimer];
		_MMTotalImageCount = MMImageArray.count * 100;
	} else {
		_MMTotalImageCount = MMImageArray.count;
		[self removeMyTimer];
	}
	
	if (!_MMPage) {
		[self addSubview:self.MMPage];
	}
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval
{
	_timeInterval = timeInterval;
	if (timeInterval <= 0) {
		_timeInterval = 2.0f;
	}
	
	[self removeMyTimer];
	[self addMyTimer];
}

#pragma mark - getter
- (UICollectionView *)MMCollectionView{
	if (!_MMCollectionView) {
		_MMCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.MMFlowLayout];
		_MMCollectionView.showsHorizontalScrollIndicator = NO;
		_MMCollectionView.delegate = self;
		_MMCollectionView.dataSource = self;
		_MMCollectionView.showsHorizontalScrollIndicator = NO;
		_MMCollectionView.pagingEnabled = YES;
		[_MMCollectionView registerClass:[MMCycleViewCell class] forCellWithReuseIdentifier:CellID];
	}
	return _MMCollectionView;
}

- (UICollectionViewFlowLayout *)MMFlowLayout{
	if (!_MMFlowLayout) {
		_MMFlowLayout = [[UICollectionViewFlowLayout alloc] init];
		_MMFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
		_MMFlowLayout.itemSize = self.bounds.size;
		_MMFlowLayout.minimumLineSpacing = 0;
		_MMFlowLayout.minimumInteritemSpacing = 0;
	}
	return _MMFlowLayout;
}

- (UIPageControl *)MMPage{
	if (!_MMPage) {
		_MMPage = [[UIPageControl alloc] init];
		_MMPage.numberOfPages = self.MMImageArray.count;
		_MMPage.hidesForSinglePage = true;
		_MMPage.currentPage = 0;
	}
	return _MMPage;
}

@end
																																	
