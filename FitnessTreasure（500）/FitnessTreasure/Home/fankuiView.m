//
//  fankuiView.m
//  微健身
//
//  Created by qingyun on 16/1/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "fankuiView.h"


@interface fankuiView ()<UITextViewDelegate>
@property (nonatomic ,strong)UITextView *textView;
@property (nonatomic ,strong) UIImageView *img;

@end

@implementation fankuiView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Feedback";
    
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"发送"] style:UIBarButtonItemStylePlain target:self action:@selector(send:)];
    
    self.navigationItem.rightBarButtonItem = btn;
    

    
    self.view.backgroundColor = [UIColor whiteColor];
    _img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _img.image = [UIImage imageNamed:@"bg.jpg"];
    _img.alpha = 1;
    [self.view addSubview:_img];

    
    _textView = [[UITextView alloc] init];
    
    //创建一个textfield 来x写反馈。
    _textView = [[UITextView alloc] init];
    _textView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    _textView.font = [UIFont systemFontOfSize:16];
    
    _textView.textColor = [UIColor redColor];
    _textView.delegate = self;
    _textView.alpha = 0.6;
    //设置圆角，边框属性
    self.textView.layer.cornerRadius = 8.0f;
    self.textView.layer.borderWidth = 2;
    
    
    [self.view addSubview:_textView];
    [_textView setText:@"Your valuable advice will be our motivation for progress!! "];
 
    [self upsave];
    // Do any additional setup after loading the view.
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([_textView.text isEqualToString:@"Your valuable advice will be our motivation for progress!!"]) {
        _textView.text = @"";
    }
}
-(void)upsave{

    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        

    }];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).with.offset(20);
            make.right.equalTo(self.view.mas_right).with.offset(-20);
            make.top.equalTo(self.view.mas_top).with.offset(150);
            make.height.equalTo(@250);
        
        }];

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)send:(UIBarButtonItem *)sander{

    
    //设置弹窗
    UIAlertView *send = [[UIAlertView alloc] initWithTitle:@"Remind" message:@"The content has been sent. Thank you for your feedback" delegate:self cancelButtonTitle:@"YES" otherButtonTitles: nil];
        //设置弹窗的风格
        send.alertViewStyle = UIAlertViewStyleDefault;
        //弹出alertView
        [send show];
    [self.navigationController popViewControllerAnimated:YES];


    
}
//取消响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%s",__func__);
    
    //父视图结束编辑，子视图失去第一响应
    [self.view endEditing:YES];
    
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
