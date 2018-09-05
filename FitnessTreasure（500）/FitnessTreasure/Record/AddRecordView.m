//
//  AddRecordView.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/27.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "AddRecordView.h"
#define fileName @"WJS.plist"

@interface AddRecordView ()
@property (nonatomic ,strong) UIImageView *img;
@property (nonatomic ,strong)UILabel *label;
@property (nonatomic ,strong)UITextView *textView;
@property(nonatomic,strong) NSString *filePath;
@property (nonatomic ,strong)NSArray *data;
@end

@implementation AddRecordView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScreenW, fScreenH)];
    _img.image = [UIImage imageNamed:@"bg"];
    _img.alpha = 0.8;
    [self.view addSubview:_img];
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc] initWithTitle:@"save" style:(UIBarButtonItemStyleDone) target:self action:@selector(clickSave:)];
    self.navigationItem.rightBarButtonItem = btn2;
    self.navigationItem.title = @"Please add new records below";
    
    //设置时间的lable
    _label = [[UILabel alloc] init];
    [_label setText:@" The Event:"];
    _label.font = [UIFont systemFontOfSize:22];
    _label.textColor = [UIColor blackColor];
    
    [self.view addSubview:_label];
    //创建一个textfield 来添加记录。
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(45, 193, 285, 160)];
    _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _textView.font = [UIFont systemFontOfSize:18];
    _textView.textColor = [UIColor blackColor];
    _textView.alpha = 0.7;
    //设置圆角，边框属性
    self.textView.layer.cornerRadius = 6.0f;
    self.textView.layer.borderWidth = 2;
    [self.view addSubview:_textView
     ];
    [_textView setText:@"Time :\nEvent :"];
    [self upsave];
}


// 将数据保存至plist文件
-(void)save{
    
    NSString *docPath =  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *filePath = [docPath stringByAppendingPathComponent:@"WJS.plist"];
    _data = @[_textView.text];
    [_data writeToFile:filePath atomically:YES];
}
//设置自动布局
-(void)upsave{
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(30);
        make.right.equalTo(self.view.mas_right).with.offset(-30);
        make.top.equalTo(self.view.mas_top).with.offset(150);
        make.height.equalTo(@300);
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textView.mas_top).with.offset(-5);
        make.left.equalTo(self.view.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
}
//保存记录
-(void)clickSave:(UIBarButtonItem *)sender{
    [self save];
    _addLabelValue(_textView.text);
    [self.navigationController popViewControllerAnimated:YES];
    
}


//取消响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //父视图结束编辑，子视图失去第一响应
    [self.view endEditing:YES];
    
}
@end
