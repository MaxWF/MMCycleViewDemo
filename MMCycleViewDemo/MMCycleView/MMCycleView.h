//
//  MMCycleView.h
//  MMCycleViewDemo
//
//  Created by Max on 2021/3/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCycleView : UIView

/*
 *  占位图
 */
@property(nonatomic, strong) UIImage *placeHolderImg;

/*
 *  加载本地图片数组
 */
@property(nonatomic, strong) NSMutableArray *localImgArr;

/*
 *  加载网络图片数组
 */
@property(nonatomic, strong) NSMutableArray *networkImgArr;

/*
 *  循环时间
 */
@property(nonatomic, assign) NSTimeInterval timeInterval;


/**
 *  加载本地图片资源
 *
 *  @param  frame   设置MMCycleView的frame
 *  @param  localArray  本地图片本地图片数组数组
 *
 *  @return MMCycleView对象
 */
+ (instancetype)creatMMViewWithFrame:(CGRect)frame localArray:(NSArray *)localArray;

/**
 *  加载本地图片资源
 *
 *  @param  frame   设置MMCycleView的frame
 *  @param  networkArray  本地图片本地图片数组数组
 *
 *  @return MMCycleView对象
 */
+ (instancetype)creatMMViewWithFrame:(CGRect)frame networkArray:(NSArray *)networkArray placeHolderImg:(UIImage *)placeHolderImg;

@end

NS_ASSUME_NONNULL_END
