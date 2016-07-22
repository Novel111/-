//
//  SEMNetworkingManager.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMNetworkingManager.h"
#import "hotTopicsModel.h"
#import "DataArchive.h"
NSString* const hotTopics = @"/hust/university/hotTopics";
NSString* const hotTopicsCache = @"hotTopicsCache";
@implementation SEMNetworkingManager
+ (instancetype)sharedInstance
{
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSURL* url = [NSURL URLWithString: @"http://dev.12yards.cn"];
        _sharedInstance = [[self alloc] initWithBaseURL: url];
    });
    return _sharedInstance;
}

- (NSURLSessionTask*)fetchHotTopics:(void (^)(id data))successBlock
                       failure:(void (^)(NSError *aError))failureBlock
{
    [self.requestSerializer setQueryStringSerializationWithStyle:AFHTTPRequestQueryStringDefaultStyle];
    return [self GET: hotTopics parameters: nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        hotTopicsModel* model = [hotTopicsModel mj_objectWithKeyValues:responseObject];
        successBlock(model.resp);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
    }];
}
@end
