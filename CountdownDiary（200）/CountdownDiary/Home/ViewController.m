//
//  ViewController.m
//  CountdownDiary
//
//  Created by buyun-wutao on 2018/8/6.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UIButton *SetBtn;
@property (nonatomic ,strong) UIButton *AddBtn;
@property (nonatomic ,strong) UIImageView *ImgView;
@property (nonatomic ,strong) UILabel *TopTitle;
@property (nonatomic ,strong) UILabel *LeftTitle;
@property (nonatomic ,strong) UILabel *RightTitle;

@property (nonatomic ,strong) UILabel *Name;
@property (nonatomic ,strong) UILabel *Day;
@property (nonatomic ,strong) UILabel *Target;
@property (nonatomic ,strong) UITableView  *myTable;

@property (nonatomic ,strong) NSMutableArray *DayArray;
@property (nonatomic ,strong) NSString *dayNumber;

@end

@implementation ViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.DayArray = [[DataBase sharedDataBase] getAllDay];
    self.DayArray  = (NSMutableArray *)[[self.DayArray  reverseObjectEnumerator] allObjects];
    NSLog(@"数组：%@",self.DayArray);
    if (self.DayArray.count >0) {
        DayModel *model = [[DayModel alloc] init];
        model = _DayArray[0];
        self.Name.text = model.Name;
        [self SetTime: model.Time];
        self.Target.text = [NSString stringWithFormat:@"Targer time : %@",model.Time];
        self.Day.text = [NSString stringWithFormat:@"%@   Day",_dayNumber];
        
        NSData *imgData = [[NSData alloc]
                           initWithBase64EncodedString:model.imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *img = [UIImage imageWithData:imgData];
        self.ImgView.image = img;
        [self.myTable reloadData];
    }else{
        self.Name.text =@"";
        self.Target.text = @"";
        self.Day.text = @"";
        self.ImgView.image = [UIImage imageNamed:@"time11"];
    }

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _ImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, fScreenW, fScreenW-20)];
    _SetBtn = [[UIButton alloc] init];
    _AddBtn = [[UIButton alloc] init];
    _TopTitle = [[UILabel alloc] init];
    _Name = [[UILabel alloc] init];
    _LeftTitle = [[UILabel alloc] init];
    _RightTitle = [[UILabel alloc] init];
    _Day = [[UILabel alloc] init];
    _Target = [[UILabel alloc] init];
 
    [self.view addSubview:_ImgView];
    [self.view addSubview:_SetBtn];
    [self.view addSubview:_AddBtn];
    [self.view addSubview:_TopTitle];
    [self.view addSubview:_Name];
    [self.view addSubview:_LeftTitle];
    [self.view addSubview:_RightTitle];
    [self.view addSubview:_Day];
    [self.view addSubview:_Target];
    
    [_ImgView setImage:[UIImage imageNamed:@"time11"]];
    [_SetBtn setImage:[UIImage imageNamed:@"设置"] forState:(UIControlStateNormal)];
    [_AddBtn setImage:[UIImage imageNamed:@"增加"] forState:(UIControlStateNormal)];
    [_SetBtn addTarget:self action:@selector(LeftSet) forControlEvents:(UIControlEventTouchDown)];
    [_AddBtn addTarget:self action:@selector(RightAdd) forControlEvents:(UIControlEventTouchDown)];
    
    [_TopTitle setFont:[UIFont systemFontOfSize:25]];
    [_TopTitle setText:@"Countdown"];
    [_TopTitle setTextColor:[UIColor whiteColor]];
    
    [_Name setFont:[UIFont systemFontOfSize:22]];
    //自动折行设置
    _Name.lineBreakMode = UILineBreakModeWordWrap;
    _Name.numberOfLines = 0;
    [_Name setTextColor:[UIColor whiteColor]];
    
    [_LeftTitle setFont:[UIFont systemFontOfSize:20]];
    [_LeftTitle setText:@"Distance"];
    [_LeftTitle setTextColor:[UIColor whiteColor]];
    
    [_RightTitle setFont:[UIFont systemFontOfSize:20]];
    [_RightTitle setText:@"Remaining"];
    [_RightTitle setTextColor:[UIColor whiteColor]];
    
    [_Day setFont:[UIFont systemFontOfSize:46]];
    [_Day setTextColor:[UIColor whiteColor]];
    
    [_Target setFont:[UIFont systemFontOfSize:18]];
    [_Target setTextColor:[UIColor whiteColor]];
    _Target.textAlignment =NSTextAlignmentCenter;
    
    _myTable = [[UITableView alloc] init];
    _myTable.delegate = self;
    _myTable.dataSource = self;
    _myTable.rowHeight = 80;
    _myTable.tableFooterView = [UIView new];
    [self.view addSubview:_myTable];
    
    
    [self setUI];
    
}
-(void)setUI{
    //左侧设置按钮
    [self.SetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(35);
        make.left.equalTo(self.view).with.offset(26);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    //右侧新增按钮
    [self.AddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(35);
        make.right.equalTo(self.view).with.offset(-26);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    //顶部标题
    [self.TopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX .equalTo(self.view);
        make.top.equalTo(self.view).with.offset(35);
    }];
    //左边标题
    [self.LeftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.TopTitle.mas_bottom).with.offset(55);
        make.left.equalTo(self.view).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        
    }];
    //Name
    [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY .equalTo(self.LeftTitle);
        make.left.equalTo(self.LeftTitle.mas_right).with.offset(15);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    //右边标题
    [self.RightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.Name.mas_bottom).with.offset(50);
        make.left.equalTo(self.view).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    //Day
    [self.Day mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY .equalTo(self.RightTitle);
        make.left.equalTo(self.view).with.offset(140);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    //_Target
    [self.Target mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX .equalTo(self.Day);
        make.bottom.equalTo(self.ImgView.mas_bottom).with.offset(-5);
        make.left.equalTo(self.view).with.offset(15);
        make.right.equalTo(self.view).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(fScreenW-30, 25));
    }];
    //Tableview
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ImgView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}


-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _DayArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 定义唯一标识
    static NSString *CellIdentifier = @"Cell";
    // 通过indexPath创建cell实例 每一个cell都是单独的
    DayCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 判断为空进行初始化 --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[DayCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _DayArray[indexPath.row];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    DayModel *model = [[DayModel alloc] init];
    model = _DayArray[indexPath.row];
    self.Name.text = model.Name;
    [self SetTime: model.Time];
    self.Target.text = [NSString stringWithFormat:@"Targer time : %@",model.Time];
    self.Day.text = [NSString stringWithFormat:@"%@   Day",_dayNumber];
    
    NSData *imgData = [[NSData alloc]
                       initWithBase64EncodedString:model.imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *img = [UIImage imageWithData:imgData];
    self.ImgView.image = img;
    [self.myTable reloadData];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        DayModel *model = self.DayArray[indexPath.row];
        [[DataBase sharedDataBase] deleteDay:model];
        self.DayArray = [[DataBase sharedDataBase] getAllDay];
        
        if (self.DayArray.count >0) {
            DayModel *model = [[DayModel alloc] init];
            model = _DayArray[0];
            self.Name.text = model.Name;
            [self SetTime: model.Time];
            self.Target.text = [NSString stringWithFormat:@"Targer time : %@",model.Time];
            self.Day.text = [NSString stringWithFormat:@"%@   Day",_dayNumber];
            
            NSData *imgData = [[NSData alloc]
                               initWithBase64EncodedString:model.imgStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
            UIImage *img = [UIImage imageWithData:imgData];
            self.ImgView.image = img;
            [self.myTable reloadData];
        }else{
            self.Name.text =@"";
            self.Target.text = @"";
            self.Day.text = @"";
            self.ImgView.image = [UIImage imageNamed:@"time11"];
        }
        [self.myTable reloadData];
    }
}

-(void)SetTime:(NSString *)timeStr{
    NSDate * nowDate = [NSDate date];
    NSString * dateString =timeStr;
    //字符串转NSDate格式的方法
    NSDate * ValueDate = [self StringTODate:dateString];
    //计算两个中间差值(秒)
    NSTimeInterval time = [nowDate timeIntervalSinceDate:ValueDate];
    
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    if (days < 0) {
        days = days-days*2;
    }
    NSString * dateValue = [NSString stringWithFormat:@"%i",days];
    _dayNumber = [NSString stringWithFormat:@"%@",dateValue];
}
//字符串转日期
- (NSDate *)StringTODate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil]];
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}
-(void)LeftSet{
    SetUpViewController *VC = [[SetUpViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:navi animated:YES completion:nil];
}
-(void)RightAdd{
    AddDiaryViewController *VC = [[AddDiaryViewController alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:navi animated:YES completion:nil];
}
- (NSMutableArray *)DayArray{
    if (!_DayArray) {
        _DayArray = [[NSMutableArray alloc] init];
        
    }
    return _DayArray;
}
@end
