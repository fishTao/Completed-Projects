//
//  DataBase.h
//  CountdownDiary
//
//  Created by buyun-wutao on 2018/8/8.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DayModel;
@interface DataBase : NSObject
 

+ (instancetype)sharedDataBase;

/**
 新增
 */
-(void)addDay:(DayModel *)day;
/**
删除
 */
-(void)deleteDay:(DayModel *)day;
/**
更新
 */
-(void)updateDay:(DayModel *)day;
/**
获取所有数据
 */
-(NSMutableArray *)getAllDay;







@end
