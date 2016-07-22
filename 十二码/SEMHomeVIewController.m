//
//  SEMHomeVIewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMHomeVIewController.h"
#import "SEMHomeVIewModel.h"
#import "SEMNetworkingManager.h"
@interface SEMHomeVIewController ()
@property (nonatomic,strong)SEMHomeVIewModel* viewModel;
@end

@implementation SEMHomeVIewController


#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
    [manager fetchHotTopics:^(id data) {
        NSLog(@"fsdf");
    } failure:^(NSError *aError) {
        NSLog(@"df");
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- controllerSetup
- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSubviews];
    [self makeConstraits];
}

- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"首页icon-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"首页icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
- (void)addSubviews
{
    
}

- (void)makeConstraits
{
    
}

- (void)bindModel
{
    self.title = self.viewModel.title;
}

#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMHomeVIewModel alloc] initWithDictionary: routerParameters];
}
#pragma mark -initialization
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setTab];
    }
    return self;
}
@end
