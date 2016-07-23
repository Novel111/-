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
#import "SDCycleScrollView.h"
#import "HomeCell.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "ReCommendNews.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "YYCategories.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HomeHeadView.h"
#import "MJRefresh.h"
#import <ReactiveViewModel/ReactiveViewModel.h>
@interface SEMHomeVIewController ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>
@property (nonatomic,strong)SEMHomeVIewModel* viewModel;
@property (nonatomic,strong)HomeHeadView* headView;
@property (nonatomic,strong)UITableView* tableView;
@end

@implementation SEMHomeVIewController


#pragma mark- lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self bindModel];
    SEMNetworkingManager* manager = [SEMNetworkingManager sharedInstance];
//    [manager fetchHotTopics:^(id data) {
//        NSLog(@"fsdf");
//    } failure:^(NSError *aError) {
//        NSLog(@"df");
//    }];
    [manager fetchReCommendNews:1 success:^(id data) {
        NSLog(@"fdsf");
    } failure:^(NSError *aError) {
        
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
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        
        [[self.viewModel.loadNewCommand execute: nil] subscribeNext:^(id x) {
            NSLog(@"%@",x);
            NSLog(@"已经更新完了");
            [self endRefresh];
        }];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [[self.viewModel.loadMoreCommand execute: nil] subscribeNext:^(id x) {
            NSLog(@"已经加载了更多了");
            NSLog(@"%@",x);
            [self endRefresh];
        }];
        
    }];
}
- (void)endRefresh
{
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
//    
//    [[NSUserDefaults standardUserDefaults] setInteger:self.viewModel.list.count forKey:NEWS_MAIN_NEWS_LIST_SHOW_COUNT];
}
- (void)makeConstraits
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.and.left.bottom.equalTo(self.view);
    }];
}

- (void)bindModel
{
    self.title = self.viewModel.title;
    [RACObserve(self.viewModel, shouldUpdataScollView) subscribeNext:^(id x) {
        if ([x  isEqual: @(YES)]) {
            NSMutableArray* titles = [[NSMutableArray alloc] init];
            NSMutableArray* url = [[NSMutableArray alloc]init];
            [self.viewModel.topics enumerateObjectsUsingBlock:^(Topic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [titles addObject:obj.title];
                [url addObject:obj.media.url];
            }];
            self.headView.scrollView.titlesGroup = titles;
            self.headView.scrollView.imageURLStringsGroup = url;
        }
    }];
    [RACObserve(self.viewModel, shouldUpdateTableview) subscribeNext:^(id x) {
        if ([x  isEqual: @(YES)]) {
            [self.tableView reloadData];
        }
    }];
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
#pragma mark -tableviewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.datasource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News* news = self.viewModel.datasource[indexPath.row];
    HomeCell* cell = (HomeCell*)[self.tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    cell.titleLabel.text = news.title;
    cell.inifoLabel.text = [news getInfo];
    cell.commentLabel.text = [@(news.commentCount) stringValue];;
    if (news.thumbnail.url)
    {
        NSURL* url = [[NSURL alloc] initWithString:news.thumbnail.url];
        [cell.newsImage sd_setImageWithURL:url
                          placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
                                   options:SDWebImageRefreshCached];
    }
    else
    {
        cell.newsImage.image = [UIImage imageNamed:@"zhanwei.jpg"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    News *news = self.viewModel.datasource[indexPath.row];
//    return [tableView fd_heightForCellWithIdentifier: NSStringFromClass([HomeCell class]) cacheByIndexPath: indexPath configuration:^(HomeCell* cell) {
//        cell.titleLabel.text = news.title;
//        cell.inifoLabel.text = [news getInfo];
//        cell.commentLabel.text = [@(news.commentCount) stringValue];;
//        if (news.thumbnail.url)
//        {
//            NSURL* url = [[NSURL alloc] initWithString:news.thumbnail.url];
//            [cell.newsImage sd_setImageWithURL:url
//                              placeholderImage:[UIImage imageNamed:@"zhanwei.jpg"]
//                                       options:SDWebImageRefreshCached];
//        }
//        else
//        {
//            cell.newsImage.image = [UIImage imageNamed:@"zhanwei.jpg"];
//        }
//    }];
    return 100;
    
}

#pragma mark -Getter
- (HomeHeadView*)headView
{
    if(!_headView)
    {
        _headView = [[HomeHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height / 2)];
        _headView.scrollView.delegate = self;
    }
    return _headView;
}
- (UITableView*)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HomeCell class] forCellReuseIdentifier:@"HomeCell"];
        
        _tableView.tableHeaderView = self.headView;
    }
    return _tableView;
}
@end
