//
//  XTCMPedometer.h
//  XTCMPedometer
//
//  Created by 薛涛 on 2018/6/13.
//  Copyright © 2018年 XT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface XTCMPedometer : NSObject

+ (id)sharedInstance;

/**
 * 获取当天步数
 */
- (void)getTodayStepsData:(CMPedometer *)pedometer success:(void(^)(id responseObject))success;

/**
 * 实时计步
 */
- (void)realTimeCaculateSteps:(CMPedometer *)pedometer success:(void(^)(id responseObject))success;

@end
