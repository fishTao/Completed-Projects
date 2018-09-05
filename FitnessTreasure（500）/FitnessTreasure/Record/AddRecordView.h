//
//  AddRecordView.h
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/27.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRecordView : UIViewController
@property (nonatomic, strong) NSString *addString;
@property (nonatomic, strong) void (^addLabelValue) (NSString *text);
@end
