//
//  DayModel.h
//  CountdownDiary
//
//  Created by buyun-wutao on 2018/8/8.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DayModel : NSObject

@property(nonatomic,strong) NSNumber *ID;

@property (nonatomic ,copy) NSString *Name;
@property (nonatomic ,copy) NSString *Time;
@property (nonatomic ,copy) NSString *imgStr;
@end
