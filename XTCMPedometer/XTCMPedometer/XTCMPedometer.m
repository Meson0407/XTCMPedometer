//
//  XTCMPedometer.m
//  XTCMPedometer
//
//  Created by 薛涛 on 2018/6/13.
//  Copyright © 2018年 XT. All rights reserved.
//

#import "XTCMPedometer.h"

XTCMPedometer *manager = nil;

@implementation XTCMPedometer

+ (id)sharedInstance {
    
    if (!manager) {
        
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [XTCMPedometer new];
        });
        
    }
    
    return manager;
    
}

// 防止使用alloc开辟空间
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (!manager) {
        static dispatch_once_t oncetToken;
        dispatch_once(&oncetToken, ^{
            manager = [super allocWithZone:zone];
        });
    }
    
    return manager;
    
}

// 防止copy
+ (id)copyWithZone:(struct _NSZone *)zone {
    
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [super copyWithZone:zone];
        });
    }
    
    return manager;
    
}

// 使用同步锁保证init创建唯一单例 ( 与once效果相同 )
- (instancetype)init {
    @synchronized(self) {
        self = [super init];
    }
    return self;
}

/**
 * 获取当天步数
 */
- (void)getTodayStepsData:(CMPedometer *)pedometer success:(void(^)(id responseObject))success{
    
    if ([CMPedometer isStepCountingAvailable]) {// 判断能否计步
     
        NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];
        
        NSDate *currentDate = [NSDate date];
        
        [pedometer queryPedometerDataFromDate:startOfToday toDate:currentDate withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            
            NSLog(@"步数：%@ 米数：%@", pedometerData.numberOfSteps,pedometerData.distance);

            NSString *str = [NSString stringWithFormat:@"%@", pedometerData.numberOfSteps];

            success(str);
            
        }];
        
    }
    
}

/**
 * 实时计步
 */
- (void)realTimeCaculateSteps:(CMPedometer *)pedometer success:(void(^)(id responseObject))success {
    
    if ([CMPedometer isStepCountingAvailable]) {
        
        NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:[NSDate date]];

        // 从data开始的实时步数记录
        [pedometer startPedometerUpdatesFromDate:startOfToday withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
            
            NSLog(@"距离%@+步数%@",pedometerData.distance, pedometerData.numberOfSteps);
            
            if (error) {
                
                NSLog(@"%@",error);
                
            }else{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSString *str = [NSString stringWithFormat:@"%@", pedometerData.numberOfSteps];
                    
                    success(str);
                    
                });
                
            }
            
        }];
        
    } else {
    }
    
}


@end
