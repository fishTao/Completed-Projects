//
//  DataBase.m
//  CountdownDiary
//
//  Created by buyun-wutao on 2018/8/8.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "DataBase.h"

static DataBase *_DBCtl = nil;
@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
}
@end
@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        _DBCtl = [[DataBase alloc] init];
        [_DBCtl initDataBase];
    }
    return _DBCtl;
}
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    if (_DBCtl == nil) {
        _DBCtl = [super allocWithZone:zone];
    }
    return _DBCtl;
}
-(id)copy{
    return self;
}

-(id)mutableCopy{
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}
-(void)initDataBase{
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
    // 初始化数据表
    NSString *DaySql = @"CREATE TABLE 'day' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'day_id' VARCHAR(255),'day_name' VARCHAR(255),'day_time' VARCHAR(255),'img_str'VARCHAR(255)) ";
    [_db executeUpdate:DaySql];
    [_db close];
}
#pragma mark - 接口
-(void)addDay:(DayModel *)day{
    [_db open];
    NSNumber *maxID = @(0);
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM day "];
    //获取数据库中最大的ID
    while ([res next]) {
        if ([maxID integerValue] < [[res stringForColumn:@"day_id"] integerValue]) {
            maxID = @([[res stringForColumn:@"day_id"] integerValue] ) ;
        }
    }
    maxID = @([maxID integerValue] + 1);
    [_db executeUpdate:@"INSERT INTO day(day_id,day_name,day_time,img_str)VALUES(?,?,?,?)",maxID,day.Name,day.Time,day.imgStr];
    [_db close];
}
-(void)deleteDay:(DayModel *)day{
    
    [_db open];
    [_db executeUpdate:@"DELETE FROM day WHERE day_id = ?",day.ID];
    [_db close];
}
-(void)updateDay:(DayModel *)day{
    [_db open];
    [_db executeUpdate:@"UPDATE 'day' SET day_name = ?  WHERE day_id = ? ",day.Name,day.ID];
    [_db executeUpdate:@"UPDATE 'day' SET day_time = ?  WHERE day_id = ? ",day.Time,day.ID];
    [_db executeUpdate:@"UPDATE 'day' SET img_str = ?  WHERE day_id = ? ",day.imgStr,day.ID];
    [_db close];
}

- (NSMutableArray *)getAllDay{
    [_db open];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM day"];
    while ([res next]) {
        DayModel *day = [[DayModel alloc] init];
        day.ID = @([[res stringForColumn:@"day_id"] integerValue]);
        day.Name = [res stringForColumn:@"day_name"];
        day.Time = [res stringForColumn:@"day_time"];
        day.imgStr = [res stringForColumn:@"img_str"];
        [dataArray addObject:day];
    }
    [_db close];
    return dataArray;
}
@end
