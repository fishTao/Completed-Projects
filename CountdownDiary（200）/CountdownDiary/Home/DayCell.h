//
//  DayCell.h
//  CountdownDiary
//
//  Created by 吴涛涛 on 2018/8/7.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayCell : UITableViewCell

@property (nonatomic ,strong)UILabel *Name;
@property (nonatomic ,strong)UILabel *Time;
@property (nonatomic ,strong)UILabel *Number;
@property (nonatomic ,strong)UILabel *day;
@property (nonatomic ,strong) NSString *dayNumber;
@property (nonatomic ,strong) DayModel *model;

-(void)setModel:(DayModel *)models;
//-(void)setArr:(NSMutableArray *)Arr;

@end
