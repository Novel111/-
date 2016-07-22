//
//  SEMHomeVIewModel.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMHomeVIewModel.h"

@implementation SEMHomeVIewModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super initWithDictionary:dictionary];
    if (self) {
        self.title = @"首页";
    }
    return self;
}
@end
