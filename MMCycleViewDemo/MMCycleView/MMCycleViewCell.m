//
//  MMCycleViewCell.m
//  MMCycleViewDemo
//
//  Created by Max on 2021/3/24.
//

#import "MMCycleViewCell.h"

@implementation MMCycleViewCell

- (instancetype)initWithFrame:(CGRect)frame{
	if (self = [super initWithFrame:frame]) {
		[self.contentView addSubview:self.imageView];
	}
	return self;
}


- (UIImageView *)imageView{
	if (!_imageView) {
		_imageView = [[UIImageView alloc] init];
	}
	return _imageView;
}

- (void)layoutSubviews{
	[super layoutSubviews];
	
	self.imageView.frame = self.bounds;
}

@end
