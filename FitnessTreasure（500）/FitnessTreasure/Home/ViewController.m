//
//  ViewController.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/26.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic ,strong) UIView *TopView;
@property (nonatomic ,strong) UIView *BottomView;
@property (nonatomic ,strong) UIScrollView *TopScrollView;
@property (retain, nonatomic) UIPageControl *pageControl;
@property (nonatomic ,strong) NSTimer *timer;

@property (nonatomic ,strong) UIImageView *TopImgView;
@property (nonatomic ,strong) UIImageView *BottomImgView;
@property (nonatomic ,strong) UIButton *Btn1;
@property (nonatomic ,strong) UIButton *Btn2;
@property (nonatomic ,strong) UIButton *Btn3;
@property (nonatomic ,strong) UIButton *Btn4;

@property (nonatomic ,strong) NSArray *videoArr;
@end

@implementation ViewController

-(NSArray *)videoArr{
    if (_videoArr == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *model = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            DataModels *image = [DataModels datasWithDictionary:dict];
            [model addObject:image];
        }
        _videoArr = model;
    }
    return _videoArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //执行图片轮播定时器
    [self addTimer];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"FitnessTreasure";
    [self setUI];
    [self RightBtn];
}
-(void)setUI{
    //TopView
    _TopView = [[UIView alloc]init];
    [self.view addSubview:_TopView];
    [_TopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(fScreenW, fScreenW*0.5));
    }];
    
    //滚动图
    _TopScrollView = [[UIScrollView alloc] init];
    [self.TopView addSubview:_TopScrollView];
    
    //循环的图片数量
    int count = 2;
    //设置contentsize
    _TopScrollView.contentSize = CGSizeMake(fScreenW * count, fScreenW*0.5);
    //分页
    self.TopScrollView.pagingEnabled = YES;
    //设置代理
    _TopScrollView.delegate = self;
    for (int i = 0;i < count; i++ ) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((fScreenW * i), 0, fScreenW, fScreenW*0.5)];
        [_TopScrollView addSubview:imageView];
        
        //设置scroll的图片
        NSString *imageName = [NSString stringWithFormat:@"sc%d",i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        
    }
    
    self.TopScrollView.backgroundColor = [UIColor blackColor];
    [_TopScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    _pageControl = [[UIPageControl alloc] init];
    [self.TopView addSubview:_pageControl];
    
    self.pageControl.numberOfPages = count;
    
    [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TopView.mas_left).offset(30);
        make.right.equalTo(self.TopView.mas_right).offset(-30);
        make.bottom.equalTo(self.TopView);
    }];
    
    

    //BottomView
    _BottomView = [[UIView alloc]init];
    _BottomView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_BottomView];
    [_BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TopView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    //BottomImgView
    _BottomImgView = [[UIImageView alloc]init];
    _BottomImgView.image = [UIImage imageNamed:@"bg"];
    [self.BottomView addSubview:_BottomImgView];
    [_BottomImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BottomView);
        make.left.equalTo(self.BottomView);
        make.right.equalTo(self.BottomView);
        make.bottom.equalTo(self.BottomView);
    }];
    
    //Btn1
    int yuan =8;//圆角的弧度
    _Btn1 = [[UIButton alloc]init];
    _Btn1.tag = 101;
    _Btn1.layer.cornerRadius = yuan;
    _Btn1.layer.masksToBounds = YES;//是否切割
    
    
    [_Btn1 addTarget:self action:@selector(Btn:) forControlEvents:(UIControlEventTouchDown)];
    [_Btn1 setImage:[UIImage imageNamed:@"video"] forState:(UIControlStateNormal)];
    [self.BottomView addSubview:_Btn1];
    [_Btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BottomView.mas_top).offset(30);
        make.left.equalTo(self.BottomView.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake((fScreenW-60-40)/2, (fScreenW-60-40)/2));
    }];
    //Btn2
    _Btn2 = [[UIButton alloc]init];
    _Btn2.tag = 102;
    _Btn2.layer.cornerRadius = yuan;
    _Btn2.layer.masksToBounds = YES;
    [_Btn2 addTarget:self action:@selector(Btn:) forControlEvents:(UIControlEventTouchDown)];
    [_Btn2 setImage:[UIImage imageNamed:@"plan"] forState:(UIControlStateNormal)];
    [self.BottomView addSubview:_Btn2];
    [_Btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BottomView.mas_top).offset(30);
        make.right.equalTo(self.BottomView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake((fScreenW-60-40)/2, (fScreenW-60-40)/2));
    }];
    //Btn3
    _Btn3 = [[UIButton alloc]init];
    _Btn3.tag = 103;
    _Btn3.layer.cornerRadius = yuan;
    _Btn3.layer.masksToBounds = YES;
    [_Btn3 addTarget:self action:@selector(Btn:) forControlEvents:(UIControlEventTouchDown)];
    [_Btn3 setImage:[UIImage imageNamed:@"record"] forState:(UIControlStateNormal)];
    [self.BottomView addSubview:_Btn3];
    [_Btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Btn1.mas_bottom).offset(20);
        make.left.equalTo(self.BottomView.mas_left).offset(30);
        make.size.mas_equalTo(CGSizeMake((fScreenW-60-40)/2, (fScreenW-60-40)/2));
    }];
    //Btn4
    _Btn4 = [[UIButton alloc]init];
    _Btn4.tag = 104;
    //切圆角和设置弧度
    _Btn4.layer.cornerRadius = yuan;
    _Btn4.layer.masksToBounds = YES;
    [_Btn4 addTarget:self action:@selector(Btn:) forControlEvents:(UIControlEventTouchDown)];
    [_Btn4 setImage:[UIImage imageNamed:@"news"] forState:(UIControlStateNormal)];
    [self.BottomView addSubview:_Btn4];
    [_Btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Btn2.mas_bottom).offset(20);
        make.right.equalTo(self.BottomView.mas_right).offset(-30);
        make.size.mas_equalTo(CGSizeMake((fScreenW-60-40)/2, (fScreenW-60-40)/2));
    }];
}
-(void)addTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(NextImage) userInfo:nil repeats:YES];
}
-(void)NextImage{
    NSInteger page = self.pageControl.currentPage;
    if (page == self.pageControl.numberOfPages -1) {
        page = 0;
    }else{
        page ++;
    }
    CGFloat offsetX = page *self.TopScrollView.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.TopScrollView.contentOffset = CGPointMake(offsetX, 0);
    }];
}
#pragma mark - scrollView滚动代理方法
// 正在滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width;
    self.pageControl.currentPage = page;
}
// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 停止定时器
    [self.timer invalidate];
}
// 结束拖拽的时候调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)Btn:(UIButton *)btn{
    
    if (btn.tag == 101) {
        MuscleViewController *videoVC = [[MuscleViewController alloc] init];
        videoVC.arr = self.videoArr;
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        [self.navigationController pushViewController:videoVC animated:YES];
        
    }else if (btn.tag == 102){
        PlanViewController *PlanVC = [[PlanViewController alloc] init];
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        [self.navigationController pushViewController:PlanVC animated:YES];
        
    }else if (btn.tag == 103){
        RecordViewController *RecordVC = [[RecordViewController alloc] init];
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        [self.navigationController pushViewController:RecordVC animated:YES];

    }else if (btn.tag == 104){
        NewsViewController *NewsVC = [[NewsViewController alloc] init];
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        [self.navigationController pushViewController:NewsVC animated:YES];
        
    }else{
        return;
    }

}


-(void)RightBtn{
    UIButton *Right = [[UIButton alloc] init];
    [Right setImage:[UIImage imageNamed:@"sz"] forState:(UIControlStateNormal)];
    [Right addTarget:self action:@selector(Menu) forControlEvents:(UIControlEventTouchDown)];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:Right];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}
-(void)Menu{
    MenuViewController *PlanVC = [[MenuViewController alloc] init];
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    [self.navigationController pushViewController:PlanVC animated:YES];
}






@end
