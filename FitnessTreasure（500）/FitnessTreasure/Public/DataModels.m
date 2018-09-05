//
//  DataModels.m
//  
//
//  Created by qingyun on 15/12/2.
//
//

#import "DataModels.h"

@implementation DataModels
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}
+(instancetype)datasWithDictionary:(NSDictionary *)dict;
{
    return [[self alloc] initWithDictionary:dict];
}
@end
