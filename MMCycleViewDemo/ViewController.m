//
//  ViewController.m
//  MMCycleViewDemo
//
//  Created by Max on 2021/3/19.
//

#import "ViewController.h"
#import "MMCycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.view.backgroundColor = UIColor.whiteColor;
	[self setupLocalPic];
}

- (void)setupLocalPic{
	NSArray *array = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];

	MMCycleView *cycleView = [MMCycleView creatMMViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) localArray:array];
	[self.view addSubview:cycleView];
}

@end
