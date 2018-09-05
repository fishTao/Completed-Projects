//
//  MenuViewController.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/26.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *myTable;
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) NSArray *arr;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Menu";
    self.view.backgroundColor = [UIColor whiteColor];
    _array = @[@"Developer information",@"Advice feedback"];
    _arr = @[@"开发者",@"反馈"];
    _myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, fScreenW, fScreenH) style:UITableViewStylePlain];
    
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.rowHeight = 60;
    _myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //让分割线从0开始显示
    _myTable.separatorInset=UIEdgeInsetsMake(0, 0, 0,0);
    
    [self.view addSubview:_myTable];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"The menu Settings";
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
    }
}


@end
