//
//  PlanViewController.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/26.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "PlanViewController.h"

@interface PlanViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) UITableView *myTable;
@property (nonatomic ,strong) NSArray *array;
@property (nonatomic ,strong) NSArray *images;

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Fitness plan";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _array = @[@"Biceps",@"Triceps",@"BackSide",@"Shank",@"Shoulder",@"Chest",@"Arm",@"abdominal",@"Thigh"];
    _images =@[@"肱 三头肌",@"肱 二头肌",@"背 部",@"小 腿",@"肩 部",@"胸 肌",@"前 臂",@"腹 肌",@"大 腿"];
    
    
    _myTable = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _myTable.rowHeight = 70;
    //让分割线从0开始显示
    _myTable.separatorInset=UIEdgeInsetsMake(0, 0, 0,0);
    
    [self.view addSubview:_myTable];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idenfile = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idenfile];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idenfile];
        cell.textLabel.text = _array[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
        
    }
    return cell;
    
}

//跳转至播放页面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    zijihuaViewController *vc = [[zijihuaViewController alloc]init];
    NSString *str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    vc.inter = [str intValue];
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    [self.navigationController pushViewController:vc animated:YES];
}












@end
