//
//  KaifazheView.m
//  微健身
//
//  Created by qingyun on 16/1/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "KaifazheView.h"
@interface KaifazheView ()

@property (nonatomic ,strong) UIImageView *img;
@property (nonatomic ,strong) UIView *views;
@property (nonatomic ,strong) UILabel *lab1;
@property (nonatomic ,strong) UILabel *lab2;
@property (nonatomic ,strong) UILabel *lab3;
@end

@implementation KaifazheView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Developers";
    self.view.backgroundColor = [UIColor whiteColor];
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _img.image = [UIImage imageNamed:@"bg"];
    _img.alpha = 0.7;
    [self.view addSubview:_img];

    
    _views = [[UIView alloc] initWithFrame:CGRectMake(45, 193, 285, 160)];
    _views.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _views.alpha = 0.8;
    //设置圆角，边框属性
    self.views.layer.cornerRadius = 8.0f;
    self.views.layer.borderWidth = 2;
    [self.view addSubview:_views];
    
    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 40)];
    _lab1.text = @"Developers：  FishTao";
    _lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 300, 40)];
    _lab2.text = @"Email：  489371523@qq.com";
    _lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 300, 100)];
    _lab3.text = @"Voice: this project material is from the network, \n if there is infringement, contact to modify!";
    //文本自适应大小
    _lab3.adjustsFontSizeToFitWidth = YES;
    //文本最多行数。
    _lab3.numberOfLines =4;

    [_views addSubview:_lab1];
    [_views addSubview:_lab2];
    [_views addSubview:_lab3];
    
    [self upsave];

    // Do any additional setup after loading the view.
}



-(void)upsave{
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        
        
    }];
    [_views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.right.equalTo(self.view.mas_right).with.offset(-20);
        make.top.equalTo(self.view.mas_top).with.offset(150);
        make.height.equalTo(@250);
        
    }];
    
}

//取消响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    NSLog(@"%s",__func__);
    
    //父视图结束编辑，子视图失去第一响应
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
