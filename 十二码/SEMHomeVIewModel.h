//
//  SEMHomeVIewModel.h
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMViewModel.h"
#import "hotTopicsModel.h"
#import "ReCommendNews.h"
#import "ReactiveCocoa.h"
#import <ReactiveViewModel/ReactiveViewModel.h>
@interface SEMHomeVIewModel : SEMViewModel
@property (nonatomic,strong) NSString   * title;
@property (nonatomic,strong) NSArray<Topic     *> *topics;
@property (nonatomic,strong) NSArray<News      *> *datasource;
@property (nonatomic,assign) BOOL       shouldUpdateTableview;
@property (nonatomic,assign) BOOL       shouldUpdataScollView;
@property (nonatomic,strong) RACCommand * loadNewCommand;
@property (nonatomic,strong) RACCommand * loadMoreCommand;
@end
