//
//  AddDiaryViewController.m
//  CountdownDiary
//
//  Created by 吴涛涛 on 2018/8/6.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "AddDiaryViewController.h"

@interface AddDiaryViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic, assign)int keyboardHeight;

@property (nonatomic ,strong) UIView *topView;
@property (nonatomic ,strong) UIImageView *imgView;
@property (nonatomic ,strong) UIButton *imgBtn;
@property (nonatomic ,strong) UILabel *lable1;
@property (nonatomic ,strong) UILabel *lable2;
@property (nonatomic ,strong) UIView *line1;
@property (nonatomic ,strong) UIView *line2;

@property (nonatomic ,strong) UITextField *Theme;
@property (nonatomic ,strong) UITextField *Time;
@property (nonatomic ,strong) UIButton *TimeBtn;
@property (nonatomic ,strong) UIButton *SendBtn;
@property (strong, nonatomic) MHDatePicker *selectDatePicker;
@property (nonatomic ,assign) BOOL isImage;

@property (nonatomic ,strong) NSMutableArray *imgArr;
@property (nonatomic ,strong) NSMutableArray *ThemeArr;
@property (nonatomic ,strong) NSMutableArray *TimeArr;
@property (nonatomic ,strong) NSArray *DayArr;
@end

@implementation AddDiaryViewController

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyboardHeight = keyboardRect.size.height-100;//键盘的高度减去textField居下的高度，使键盘弹出后输入框紧贴在键盘上面。
    
    CGRect frame = self.view.frame;
    frame.origin.y = - _keyboardHeight;
    self.view.frame = frame;
    
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    self.view.frame = frame;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isImage = NO;
    _imgArr = [NSMutableArray array];
    _ThemeArr = [NSMutableArray array];
    _TimeArr = [NSMutableArray array];
    _DayArr = [NSArray array];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"Add countdown";
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem = btn;
    
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_topView];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.image = [UIImage imageNamed:@"Addimage"];
    [self.view addSubview:_imgView];
    self.imgBtn = [[UIButton alloc] init];
    [self.imgBtn addTarget:self action:@selector(imgClick) forControlEvents:(UIControlEventTouchDown)];
    [self.view addSubview:self.imgBtn];
    
    self.lable1 = [[UILabel alloc] init];
    self.Theme = [[UITextField alloc] init];
    self.line1 = [[UIView alloc] init];
    self.lable2 = [[UILabel alloc] init];
    self.Time = [[UITextField alloc] init];
    self.TimeBtn = [[UIButton alloc] init];
    self.line2 = [[UIView alloc] init];
    self.SendBtn = [[UIButton alloc] init];
    
    _lable1.text = @"Theme";
    _Theme.placeholder = @"Please enter the topic";
    _Theme.textAlignment = NSTextAlignmentRight ;//右对齐
    _line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _lable2.text = @"Time";
    _Time.placeholder = @"To choose time";
    _Time.textAlignment = NSTextAlignmentRight ;//右对齐
    _line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_TimeBtn addTarget:self action:@selector(ChooseTime) forControlEvents:(UIControlEventTouchDown)];
    [_SendBtn setBackgroundColor:[UIColor colorWithRed:85/255.0f green:103/255.0f blue:117/255.0f alpha:1.0]];
    [_SendBtn setTitle:@"Send" forState:(UIControlStateNormal)];
    [_SendBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _SendBtn.titleLabel.font = [UIFont systemFontOfSize: 22];
    _SendBtn.layer.cornerRadius = 8.0;
    _SendBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);//设置边框颜色
    _SendBtn.layer.borderWidth = 1.0f;//设置边框颜色
    [_SendBtn addTarget:self action:@selector(SendData) forControlEvents:(UIControlEventTouchDown)];
    
    [self.view addSubview:self.lable1];
    [self.view addSubview:self.Theme];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.lable2];
    [self.view addSubview:self.Time];
    [self.view addSubview:self.TimeBtn];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.SendBtn];
    
    [self setUI];
}
-(void)setUI{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(self.topView.mas_width).multipliedBy(0.7);
//        make.height.equalTo(self.topView.mas_width);
        make.centerY.equalTo(self.topView);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView);
        make.left.equalTo(self.topView);
        make.right.equalTo(self.topView);
        make.bottom.equalTo(self.topView);
    }];
    [self.imgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView);
        make.left.equalTo(self.topView);
        make.right.equalTo(self.topView);
        make.bottom.equalTo(self.topView);
    }];
    [self.lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.Theme mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).with.offset(20);
        make.left.equalTo(self.lable1.mas_right).with.offset(10);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable1.mas_bottom).with.offset(15);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(@1);
    }];
    [self.lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom).with.offset(20);
        make.left.equalTo(self.view).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    [self.Time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom).with.offset(20);
        make.left.equalTo(self.lable2.mas_right).with.offset(10);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    [self.TimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1.mas_bottom).with.offset(20);
        make.left.equalTo(self.lable2.mas_right).with.offset(10);
        make.right.equalTo(self.view).with.offset(-20);
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable2.mas_bottom).with.offset(15);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(@1);
    }];
    [self.SendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line2.mas_bottom).with.offset(40);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(200, 70));
    }];
}
- (void)imgClick
{
    UIActionSheet *acTionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [acTionSheet showInView:self.view];
}
#pragma mark - 相机和相册选择照片
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            ipc.delegate=self;
            ipc.allowsEditing = YES;
            //指定调用的资源为摄像头
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:ipc animated:YES completion:nil];
            
            
        }else{
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"没有或不能打开摄像头" delegate:nil cancelButtonTitle:@"确定!" otherButtonTitles:nil];
            //            [alert show];
        }
    }else if(buttonIndex==1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            UIImagePickerController * ipc = [[UIImagePickerController alloc] init];
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            ipc.delegate = self;
            ipc.allowsEditing = YES; //是否可编辑
            //打开相册选择照片
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:ipc animated:YES completion:nil];
        }else{
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"不能打开相册" delegate:nil cancelButtonTitle:@"确定!" otherButtonTitles:nil];
            //            [alert show];
        }
        
    }
}
#pragma mark - 选完照片的回调
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *) info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _imgView.image = image;
    self.isImage = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




//-(void)AddImage{
//     [self.view endEditing:YES];
//    //添加图片
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    [self presentViewController:picker animated:YES completion:nil];
//}
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    _imgView.image = image;
//    self.isImage = YES;
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}
//
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}


-(void)ChooseTime{
     [self.view endEditing:YES];
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    
    __weak typeof(self) weakSelf = self;
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        weakSelf.Time.text = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
    }];
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}



-(void)SendData{
    if ([self.Theme.text isEqualToString:@""]  || self.Theme.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"Please enter the topic"];
        return;
    }
    if ([self.Time.text isEqualToString:@""]  || self.Time.text.length < 1){
         [SVProgressHUD showErrorWithStatus:@"Please enter the time"];
        return;
    }
    if (self.isImage != YES){
        [SVProgressHUD showErrorWithStatus:@"Please select the picture"];
        return;
    }
    
    _imgArr = [[NSMutableArray alloc] init];
    //把图片转换为Base64的字符串
    NSData *data = UIImageJPEGRepresentation(self.imgView.image, 1.0f);
    NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    _DayArr = @[self.Theme.text,self.Time.text,image64];
     
    
    DayModel *day = [[DayModel alloc] init];
    day.Name = self.Theme.text;
    day.Time = self.Time.text;
    day.imgStr = image64;
    
    [[DataBase sharedDataBase] addDay:day];
    
    [self backBtn]; 
}
-(void)backBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//取消响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //父视图结束编辑，子视图失去第一响应
    [self.view endEditing:YES];
}
@end
