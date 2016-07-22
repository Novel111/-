//
//  SEMNetworkingManager.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SEMNetworkingManager : AFHTTPSessionManager
/**
 *  网络模块单例
 *
 *  @return 单例
 */
+ (instancetype)sharedInstance;

/*!
 *  @author 汪宇豪, 16-07-22 16:07:43
 *
 *  @brief 获取热点
 *
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *
 *  @return NSURLSessionTask
 */
- (NSURLSessionTask*)fetchHotTopics:(void (^)(id data))successBlock
                       failure:(void (^)(NSError *aError))failureBlock;

@end

