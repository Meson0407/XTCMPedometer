//
//  ViewController.m
//  XTCMPedometer
//
//  Created by 薛涛 on 2018/6/13.
//  Copyright © 2018年 XT. All rights reserved.
//

#import "ViewController.h"

#import "XTCMPedometer.h"

#import <CoreMotion/CoreMotion.h>

@interface ViewController ()

@property (nonatomic, strong) CMPedometer *pedometer1;

@property (nonatomic, strong) CMPedometer *pedometer2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _pedometer1 = [[CMPedometer alloc] init];
    _pedometer2 = [[CMPedometer alloc] init];
    
    [self createUI];
    
}

- (void)createUI {
    
    UILabel *stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 200, 50)];
    
    stepLabel.textColor = [UIColor whiteColor];
    stepLabel.font = [UIFont systemFontOfSize:16.f];
    
    stepLabel.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:stepLabel];
    
    UILabel *stepLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 200, 50)];
    
    stepLabel1.textColor = [UIColor whiteColor];
    stepLabel1.font = [UIFont systemFontOfSize:16.f];
    
    stepLabel1.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:stepLabel1];
    
    XTCMPedometer *ped = [XTCMPedometer sharedInstance];
    
    [ped getTodayStepsData:_pedometer1 success:^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            stepLabel.text = [NSString stringWithFormat:@"今日步数 = %@步", responseObject];
        });
        
    }];
    
    
    [ped realTimeCaculateSteps:_pedometer2 success:^(id responseObject) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            stepLabel1.text = [NSString stringWithFormat:@"实时步数 = %@步", responseObject];
        });
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
