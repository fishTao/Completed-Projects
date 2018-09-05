//
//  DayCell.m
//  CountdownDiary
//
//  Created by 吴涛涛 on 2018/8/7.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "DayCell.h"

@implementation DayCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.Name = [[UILabel alloc] init];
        [self addSubview:_Name];
        self.Time = [[UILabel alloc] init];
        [self addSubview:_Time];
        self.Number = [[UILabel alloc] init];
        [self addSubview:_Number];
        self.day = [[UILabel alloc] init];
        [self addSubview:_day];
        
        
        self.day.text = @"Day";
        self.Name.font = [UIFont systemFontOfSize:20];
        [self.Number setFont:[UIFont fontWithName:@"Courier" size:26]];
        [self.Number setTextColor:[UIColor colorWithRed:0.0f/255.0f green:90.0f/255.0f blue:140.0f/255.0f alpha:0.5]];
        [self.Time setTextColor:[UIColor colorWithRed:140.0f/255.0f green:140.0f/255.0f blue:140.0f/255.0f alpha:0.5]];
        self.Number.textAlignment =NSTextAlignmentRight;
        
        [self.day mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).with.offset(-5);
            make.centerY.equalTo(self);
            make.width.equalTo(@35);
        }];
        [self.Number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.day.mas_left).with.offset(-5);
            make.size.mas_equalTo(CGSizeMake(90, 50));
        }];
        [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
             make.centerY.equalTo(self);
            make.right.equalTo(self.Number.mas_left).with.offset(-10);
            make.left.equalTo(self).with.offset(15);
            make.height.equalTo(@35);
        }];
        [self.Time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(-2);
            make.left.equalTo(self).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(350, 25));
        }];
    }
    return self;
}
-(void)setModel:(DayModel *)models{
    _model = models;
    self.Name.text = _model.Name;
    self.Time.text = _model.Time;
    [self SetTime:_model.Time];
    self.Number.text = self.dayNumber;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
