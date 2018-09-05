//
//  DataModels.h
//  
//
//  Created by qingyun on 15/12/2.
//
//

#import <Foundation/Foundation.h>

@interface DataModels : NSObject
//声明属性

@property (nonatomic ,strong)NSString *image;
@property (nonatomic ,strong) NSString *string;
@property (nonatomic ,strong) NSString *title;
@property (nonatomic ,strong) NSString *tool;
@property (nonatomic ,strong) NSString *method;
@property (nonatomic ,strong) NSString *mp4;


-(instancetype)initWithDictionary:(NSDictionary *)dict;
+(instancetype)datasWithDictionary:(NSDictionary *)dict;





@end
