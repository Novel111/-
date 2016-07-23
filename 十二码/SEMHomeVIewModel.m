//
//  SEMHomeVIewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMHomeVIewModel.h"
#import "SEMNetworkingManager.h"
@implementation SEMHomeVIewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.title = @"首页";
        [self fetchData];
    }
    return self;
}

- (void)fetchData
{
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchReCommendNews:0 success:^(id data) {
        self.datasource = data;
        self.shouldUpdateTableview = YES;
    } failure:^(NSError *aError) {
        NSLog(@"%@",aError);
    }];
    [manager fetchHotTopics:^(id data) {
        self.topics = data;
        self.shouldUpdataScollView = YES;
    } failure:^(NSError *aError) {
        
    }];
}

- (RACCommand*)loadNewCommand
{
    if (!_loadNewCommand)
    {
        _loadNewCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"正在更新数据");
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _loadNewCommand;
}

- (RACCommand*)loadMoreCommand
{
    if (!_loadMoreCommand) {
        _loadMoreCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                NSLog(@"正在获取更过数据");
                [subscriber sendNext:@1];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
    }
    return _loadMoreCommand;
}
@end
