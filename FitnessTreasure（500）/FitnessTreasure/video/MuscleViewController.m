//
//  MuscleViewController.m
//  FitnessTreasure
//
//  Created by buyun-wutao on 2018/7/26.
//  Copyright © 2018年 Tao. All rights reserved.
//

#import "MuscleViewController.h"
#import "ExerciseDetails.h"
@interface MuscleViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property (weak, nonatomic) IBOutlet UIButton *btn7;
@property (weak, nonatomic) IBOutlet UIButton *btn8;
@property (weak, nonatomic) IBOutlet UIButton *btn9;

@end

@implementation MuscleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose the muscles you exercise";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置边框颜色
    _btn1.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn3.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn2.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn4.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn5.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn6.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn7.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn8.layer.borderColor = [[UIColor blackColor] CGColor];
    _btn9.layer.borderColor = [[UIColor blackColor] CGColor];
    
    //设置边框宽度
    _btn1.layer.borderWidth = 1.0f;
    _btn2.layer.borderWidth = 1.0f;
    _btn3.layer.borderWidth = 1.0f;
    _btn4.layer.borderWidth = 1.0f;
    _btn5.layer.borderWidth = 1.0f;
    _btn6.layer.borderWidth = 1.0f;
    _btn7.layer.borderWidth = 1.0f;
    _btn8.layer.borderWidth = 1.0f;
    _btn9.layer.borderWidth = 1.0f;
    _btn1.layer.cornerRadius = 4.0f;
    _btn2.layer.cornerRadius = 4.0f;
    _btn3.layer.cornerRadius = 4.0f;
    _btn4.layer.cornerRadius = 4.0f;
    _btn5.layer.cornerRadius = 4.0f;
    _btn6.layer.cornerRadius = 4.0f;
    _btn7.layer.cornerRadius = 4.0f;
    _btn8.layer.cornerRadius = 4.0f;
    _btn9.layer.cornerRadius = 4.0f;
    _btn1.layer.masksToBounds = YES;
    _btn2.layer.masksToBounds = YES;
    _btn3.layer.masksToBounds = YES;
    _btn4.layer.masksToBounds = YES;
    _btn5.layer.masksToBounds = YES;
    _btn6.layer.masksToBounds = YES;
    _btn7.layer.masksToBounds = YES;
    _btn8.layer.masksToBounds = YES;
    _btn9.layer.masksToBounds = YES;
}

- (IBAction)img1:(UIButton *)sender {
        [self goToDetail:sender];
}
- (IBAction)img2:(UIButton *)sender {
        [self goToDetail:sender];
}
- (IBAction)img3:(UIButton *)sender {
        [self goToDetail:sender];
}
- (IBAction)img4:(UIButton *)sender {
         [self goToDetail:sender];
}
- (IBAction)img5:(UIButton *)sender {
         [self goToDetail:sender];
}
- (IBAction)img6:(UIButton *)sender {
         [self goToDetail:sender];
}
- (IBAction)img7:(UIButton *)sender {
         [self goToDetail:sender];
}
- (IBAction)img8:(UIButton *)sender {
        [self goToDetail:sender];
}
- (IBAction)img9:(UIButton *)sender {
         [self goToDetail:sender];
}


-(void)goToDetail:(UIButton *)sender{
    ExerciseDetails *detailView = [[ExerciseDetails alloc] init];
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    detailView.BtnTag = sender.tag;
    switch (sender.tag) {
        case 101:
            detailView.titleStr = @"triceps";
            break;
        case 102:
            detailView.titleStr = @"biceps";
            break;
        case 103:
            detailView.titleStr = @"backside";
            break;
        case 104:
            detailView.titleStr = @"shank";
            break;
        case 105:
            detailView.titleStr = @"shoulder";
            break;
        case 106:
            detailView.titleStr = @"chest";
            break;
        case 107:
            detailView.titleStr = @"arm";
            break;
        case 108:
            detailView.titleStr = @"abdominal";
            break;
        case 109:
            detailView.titleStr = @"thigh";
            break;
        default:
            break;
    }
    detailView.array = self.arr;
    [self.navigationController pushViewController:detailView animated:YES];
}




@end
