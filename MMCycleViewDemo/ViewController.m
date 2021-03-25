//
//  ViewController.m
//  MMCycleViewDemo
//
//  Created by Max on 2021/3/19.
//

#import "ViewController.h"
#import "MMCycleView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *localBtn;

@property (nonatomic, strong) UIButton *networkBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.view.backgroundColor = UIColor.whiteColor;
	[self.view addSubview:self.localBtn];
	[self.view addSubview:self.networkBtn];

}

- (void)localClick{
	[self setupLocalPic];
}

- (void)networkClick{
	[self setupNetworkPic];
}

- (void)setupLocalPic{
	NSArray *array = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg"];

	MMCycleView *cycleView = [MMCycleView creatMMViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) localArray:array];
	cycleView.timeInterval = 10;
	[self.view addSubview:cycleView];
}

- (void)setupNetworkPic{
//	NSArray *array = @[@"https://goss3.cfp.cn/creative/vcg/800/new/VCG211177178924.jpg", @"https://goss3.cfp.cn/creative/vcg/800/new/VCG41N728851723.jpg"];
	
	NSArray *array = @[@"http://i3.download.fd.pchome.net/t_960x600/g1/M00/07/09/oYYBAFMv8q2IQHunACi90oB0OHIAABbUQAAXO4AKL3q706.jpg",
					   @"http://images.weiphone.net/attachments/photo/Day_120308/118871_91f6133116504086ed1b82e0eb951.jpg",
					   @"http://benyouhuifile.it168.com/forum/macos/attachments/month_1104/110425215921926a173e0f728e.jpg",
					   @"http://benyouhuifile.it168.com/forum/macos/attachments/month_1104/1104241737046031b3a754f783.jpg"];
	
	MMCycleView *cycleView = [MMCycleView creatMMViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) networkArray:array placeHolderImg:[UIImage imageNamed:@"1.jpg"]];
	cycleView.timeInterval = 1;
	[self.view addSubview:cycleView];
}

- (UIButton *)localBtn{
	if (!_localBtn) {
		_localBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_localBtn.frame = CGRectMake(20, self.view.frame.size.height / 2, 150, 50);
		[_localBtn setTitle:@"本地图片轮播" forState:UIControlStateNormal];
		[_localBtn addTarget:self action:@selector(localClick) forControlEvents:UIControlEventTouchUpInside];
		_localBtn.backgroundColor = UIColor.whiteColor;
		[_localBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
		_localBtn.layer.borderWidth = .4f;
		_localBtn.layer.masksToBounds = YES;
	}
	return _localBtn;
}

- (UIButton *)networkBtn{
	if (!_networkBtn) {
		_networkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		_networkBtn.frame = CGRectMake(self.view.frame.size.width - 20 - 150, self.view.frame.size.height / 2, 150, 50);
		[_networkBtn setTitle:@"网络图片轮播" forState:UIControlStateNormal];
		[_networkBtn addTarget:self action:@selector(networkClick) forControlEvents:UIControlEventTouchUpInside];
		_networkBtn.backgroundColor = UIColor.whiteColor;
		[_networkBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
		_networkBtn.layer.borderWidth = .4f;
		_networkBtn.layer.masksToBounds = YES;
	}
	return _networkBtn;
}

@end
