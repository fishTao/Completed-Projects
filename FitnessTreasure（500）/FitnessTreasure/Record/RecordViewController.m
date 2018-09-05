//
//  RecordViewController.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/26.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "RecordViewController.h"
#import "AddRecordView.h"
@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSMutableArray *datas;
@property (nonatomic ,strong) UITableView *myTable;
@property (nonatomic ,strong) UILabel *lable1;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Record";
    self.view.backgroundColor = [UIColor whiteColor];
    _lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _lable1.text = @"Click ‘+’ at the top right to add a record.";
    _lable1.textColor = [UIColor redColor];
    _lable1.font = [UIFont fontWithName:@"Arial" size:17];
    _lable1.textAlignment = YES;
    //自动折行设置
    _lable1.lineBreakMode = UILineBreakModeWordWrap;
    _lable1.numberOfLines = 0;
    
    [self saveload];
    
    _datas = [[NSMutableArray alloc] init];
    //读取plist文件 =====字典
    NSString *dopath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [dopath stringByAppendingPathComponent:@"WJS.plist"];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filepath];
    
    if (arr.count !=0) {
        _lable1.hidden = YES;
        _datas = arr;
    }else{
        _lable1.hidden = NO;
    }
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addjilu:)];
    self.navigationItem.rightBarButtonItem = btn1;
    
#pragma mark     ----------UITableView------
    
    _myTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, fScreenW, fScreenH) style:UITableViewStylePlain];
    //设置代理
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _myTable.rowHeight = 80;
    
    [self.view addSubview:_myTable];
    _myTable.tableHeaderView = _lable1;
    
}
-(void)saveload{
    //读取plist文件 =====字典
    NSString *dopath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [dopath stringByAppendingPathComponent:@"WJS.plist"];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filepath];
    _datas = arr;
}
#pragma mark      ----------tableView DataSource-------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}

#pragma mark  =======设置删除======
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.datas removeObjectAtIndex:indexPath.row];
    
    NSString *dopath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filepath = [dopath stringByAppendingPathComponent:@"WJS.plist"];
    [_datas writeToFile:(filepath) atomically:YES];
    //移除tableView中的数据
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    if (self.datas.count >0) {
        self.lable1.hidden = YES;
    }else{
        self.lable1.hidden = NO;
    }
    
    [self.myTable reloadData];
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identfier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identfier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfier];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.text = _datas[indexPath.row];
    return cell;
    
}

-(void)addjilu:(UIBarButtonItem *)sender{

    //新建并跳转至ViewController
    AddRecordView *View = [[AddRecordView alloc] init];
    View.addLabelValue = ^(NSString *string){

        [self.datas addObject:string];
        if (self.datas.count >0) {
            self.lable1.hidden = YES;
        }else{
            self.lable1.hidden = NO;
        }
        [self.myTable reloadData];


        NSString *dopath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *filepath = [dopath stringByAppendingPathComponent:@"WJS.plist"];
        [self.datas writeToFile:(filepath) atomically:YES];

    };
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    [self.navigationController pushViewController:View animated:YES];

}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
}


@end
