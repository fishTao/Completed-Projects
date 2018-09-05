//
//  ExerciseDetails.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/26.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "ExerciseDetails.h"

#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface ExerciseDetails ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIView *uiView;
@property (nonatomic ,strong) AVPlayerLayer *playerLayer;
@property (nonatomic ,strong) UILabel *lab1;
@property (nonatomic ,strong) UILabel *lab2;
@property (nonatomic ,strong) AVPlayer *player;


@end

@implementation ExerciseDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =[NSString stringWithFormat:@"%@",self.titleStr];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    //接收arr的数据
    DataModels *model = _array[_BtnTag-101];
    NSLog(@"%@",model);
    
    
    
    _uiView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, fScreenW, fScreenW*0.55)];
    [self.view addSubview:_uiView];
    NSString *path = [[NSBundle mainBundle]pathForResource:model.mp4 ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    _player = [[AVPlayer alloc]initWithPlayerItem:item];
    
    //生成layer
    _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    _playerLayer.frame = CGRectMake(0, 0,self.uiView.frame.size.width, _uiView.frame.size.height);
    //设置屏幕填充
    _playerLayer.videoGravity=AVLayerVideoGravityResizeAspect;
    [self.uiView.layer addSublayer:_playerLayer];
    [_player play];
    
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
    //创建一个文本框，用来陈述图片的锻炼方法。
    _lab1 = [[UILabel alloc]init];
    _lab1.text = model.string;
    _lab1.adjustsFontSizeToFitWidth = YES;
    _lab1.numberOfLines = 10;
    _lab1.textColor = [UIColor brownColor];
    _lab1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_lab1];
    //Label 2
    _lab2 = [[UILabel alloc]init];
    _lab2.text = model.method;
    _lab2.adjustsFontSizeToFitWidth = YES;
    _lab2.numberOfLines = 10;
    _lab2.textColor = [UIColor brownColor];
    _lab2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_lab2];
    
    
    UILabel *title1 = [[UILabel alloc] init];
    title1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    title1.font = [UIFont systemFontOfSize:20];
    title1.text = @"Introduce the muscles :";
    [self.view addSubview:title1];
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.uiView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(fScreenW-25, 20));
    }];
    
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(title1.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(25);
        make.right.equalTo(self.view).with.offset(-25);
        
        make.height.lessThanOrEqualTo(@250);
        make.height.greaterThanOrEqualTo(@(20));
    }];
    UILabel *title2 = [[UILabel alloc] init];
    title2.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.f];
    title2.font = [UIFont systemFontOfSize:20];
    title2.text = @"Ways to exercise :";
    [self.view addSubview:title2];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lab1.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(fScreenW-25, 20));
    }];
    
    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(25);
        make.right.equalTo(self.view).with.offset(-25);
        
        make.height.lessThanOrEqualTo(@250);
        make.height.greaterThanOrEqualTo(@(20));
        
        
    }];
}
- (void)runLoopTheMovie:(NSNotification *)n{
    
    AVPlayerItem * p = [n object];
    [p seekToTime:kCMTimeZero];
    
    [_player play];
    NSLog(@"重播");
}


@end
