//
//  SEMGameViewController.m
//  十二码
//
//  Created by 汪宇豪 on 16/7/22.
//  Copyright © 2016年 汪宇豪. All rights reserved.
//

#import "SEMGameViewController.h"
#import "SEMGameVIewModel.h"
@interface SEMGameViewController ()
@property (nonatomic,strong)SEMGameVIewModel* viewModel;
@end

@implementation SEMGameViewController


#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
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
- (void)setTab
{
    UIImage* image = [[UIImage imageNamed:@"赛事icon=灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* selectedImage = [[UIImage imageNamed:@"赛事icon-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"赛事" image:image selectedImage:selectedImage];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:37/255.0 green:153/255.0 blue:31/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}
#pragma mark -viewModelSet

- (void)setRouterParameters:(NSDictionary *)routerParameters
{
    self.viewModel = [[SEMGameVIewModel alloc] initWithDictionary: routerParameters];
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
