//
//  SetUpViewController.m
//  CountdownDiary
//
//  Created by 吴涛涛 on 2018/8/6.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "SetUpViewController.h"

@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *myTable;
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) NSArray *arr;
@property (nonatomic ,strong)  NSTimer *timer;

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Set countdown";
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:self action:@selector(backBtn)];
    self.navigationItem.leftBarButtonItem = btn;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    _array = @[@"Developer information",@"Advice feedback",@"Clear the cache",@"The version number"];
    _arr = @[@"22",@"11",@"44",@"55"];
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, fScreenW, fScreenH) style:UITableViewStylePlain];
    
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.rowHeight = 60;
    _myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //让分割线从0开始显示
    _myTable.separatorInset=UIEdgeInsetsMake(0, 0, 0,0);
    
    [self.view addSubview:_myTable];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenfile = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenfile];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfile];
        cell.imageView.image = [UIImage imageNamed:_arr[indexPath.row]];
        cell.textLabel.text = _array[indexPath.row];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        KaifazheView *view = [[KaifazheView alloc] init];UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        [self.navigationController pushViewController:view animated:YES];
        
    }if (indexPath.row == 1) {
        fankuiView *vc = [[fankuiView alloc] init];UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"";
        self.navigationItem.backBarButtonItem = returnButtonItem;
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.row == 2) {
        [SVProgressHUD showWithStatus:@"Please later…"];
        _timer = [[NSTimer alloc] init];
        _timer= [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(Clean) userInfo:nil repeats:YES];
    }if (indexPath.row == 3) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Remind" message:@"It is the latest version" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:nil]];
        // 弹出对话框
        [self presentViewController:alert animated:true completion:nil];
    }
}
-(void)Clean{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"Clean up the complete"];
    // 停止定时器
    [self.timer invalidate];
}
-(void)backBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
