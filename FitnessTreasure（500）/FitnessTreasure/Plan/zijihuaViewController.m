//
//  zijihuaViewController.m
//  微健身
//
//  Created by qingyun on 16/1/5.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "zijihuaViewController.h"

@interface zijihuaViewController ()<UIScrollViewDelegate>


@property(nonatomic ,strong) UIView *myView;
@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) UILabel *label6;
@property (nonatomic ,strong) NSArray *imgArray;
@property (nonatomic ,strong) NSArray *datas;
@property (nonatomic ,strong) UIImageView *imgView;

@end

@implementation zijihuaViewController
//懒加载，添加数据。
-(NSArray *)datas
{
    if (_datas ==nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"video" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            DataModels *image = [DataModels datasWithDictionary:dict];
            [models addObject:image];
        }
        _datas = models;
        
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _myView = [UIView new];
    [self.view addSubview:_myView];
    self.title = @"Plan details";
    _imgArray = @[@"肌肉_1",@"肌肉_2",@"肌肉_3",@"肌肉_4",@"肌肉_5",@"肌肉_6",@"肌肉_7",@"肌肉_8",@"肌肉_9"];
//    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 0,fScreenW-160,210)];
    [self.view addSubview:_imgView];
     _imgView.image = [UIImage imageNamed:[NSString stringWithFormat: @"%@.jpg",_imgArray[self.inter]]];
    
    _btn1 = [[UIButton alloc] init];
    [_btn1 setImage:[UIImage imageNamed:@"左"] forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(upPage:) forControlEvents:UIControlEventTouchDown];
    [_btn1 setImage:[UIImage imageNamed:@"左高亮"] forState:UIControlStateHighlighted];
    [self.view addSubview:_btn1];
    
  
    _btn2 = [[UIButton alloc] init];
    [_btn2 setImage:[UIImage imageNamed:@"右"] forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchDown];
    [_btn2 setImage:[UIImage imageNamed:@"右高亮"] forState:UIControlStateHighlighted];
    [self.view addSubview:_btn2];
    _label1 = [[UILabel alloc] init];
    _label2 = [[UILabel alloc] init];
    _label3 = [[UILabel alloc] init];
    _label1.text = @"Planned motion frequency：";
    _label2.text = @"Methods Equipment：";
    _label3.text = @"Matters needing attention：";
    _label4 = [[UILabel alloc] init];
    _label5 = [[UILabel alloc] init];
    _label6 = [[UILabel alloc] init];

    [self.view addSubview:_label1];
    [self.view addSubview:_label2];
    [self.view addSubview:_label3];
    [self.view addSubview:_label4];
    [self.view addSubview:_label5];
    [self.view addSubview:_label6];
    
   
    [self update];
    [self setIndex];
    
}

//设置让scrollerview的值随着inde改变
- (void)setIndex{
    
    DataModels *model = self.datas[_inter];
    self.label4.text = model.title;
    self.label5.text = model.tool;
    _label4.textColor = [UIColor brownColor];
    _label5.textColor = [UIColor brownColor];
    //文本自适应大小
    _label5.adjustsFontSizeToFitWidth = YES;
    _label5.numberOfLines = 3;
    
    self.label6.text = model.method;
    _label6.textColor = [UIColor brownColor];
    _label6.adjustsFontSizeToFitWidth = YES;
    _label6.numberOfLines = 10;

    
}

-(void)next:(UIButton *)sander{
    _btn1.hidden = NO;
    if (_inter < 8) {
        _inter  = self.inter+ 1;
        [self setIndex];
        _imgView.image = [UIImage imageNamed:[NSString stringWithFormat: @"%@.jpg",_imgArray[_inter]]];
    }else{
        _btn2.hidden = YES;
    }
}
-(void)upPage:(UIButton *)secder{
    _btn2.hidden = NO;
    if (_inter > 0) {
        _inter  = self.inter-1;
        [self setIndex];
        _imgView.image = [UIImage imageNamed:[NSString stringWithFormat: @"%@.jpg",_imgArray[_inter]]];
    }else{
        _btn1.hidden = YES;
    }
}


//////////  添加约束
-(void)update{
    
    [_myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left).with.offset(40);
        make.right.equalTo(self.view.mas_right).with.offset(-40);
        make.height.equalTo(@210);
    }];
    

    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.left.equalTo(self.view.mas_left).with.offset(5);

            make.centerY.equalTo(@[self.btn2,self.btn1,self.myView]);
            make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.myView.mas_right).with.offset(5);
            make.right.equalTo(self.view.mas_right).with.offset(-5);
            make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
        
    [_label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.myView.mas_bottom).with.offset(20);
            make.left.equalTo(self.view.mas_left).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(fScreenW, 25));
    }];
        
    [_label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(fScreenW-80, 25));
    }];
    
    [_label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label4.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(fScreenW, 25));

    }];
    
    [_label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label2.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(fScreenW-80, 25));
    }];
    
    [_label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label5.mas_bottom).with.offset(20);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(fScreenW, 25));
    }];
    
    [_label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label3.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(fScreenW-80, 150));

    }];

}



@end
