//
//  MDABizManager.h
//  MediaAssistant
//
//  Created by Hirat on 16/7/7.
//  Copyright © 2016年 Lehoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDABizManager : NSObject
@property (nonatomic,assign)BOOL userLogined;
/**
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;
- (void)updataUserLoginInfo;

@end
