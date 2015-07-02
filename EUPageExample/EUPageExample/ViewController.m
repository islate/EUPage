//
//  ViewController.m
//  EUPageExample
//
//  Created by wangliqun on 15/6/1.
//  Copyright (c) 2015年 wangliqun. All rights reserved.
//

#import "ViewController.h"
#import "EUMediaModel.h"
#import "EUMediaViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _showCycleView = [[EUPageView alloc] initWithFrame:self.view.bounds scrollDirection:UICollectionViewScrollDirectionHorizontal];
    _showCycleView.delegate = self;
    _showCycleView.dataSource = self;
    _showCycleView.needCycleShow = YES;
    _showCycleView.pageTime = 10;
    [self.view addSubview:_showCycleView];
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadDataSource
{
    NSMutableArray *phoneColumnlist= [[NSMutableArray alloc] initWithObjects:
                                      @"http://www.bing.com",
                                       @"http://www.yahoo.com",
                                      @"http://s.cn.bing.net/az/hprichbg/rb/WaterliliesYuanmingyuan_ZH-CN10533925188_1920x1080.jpg",
                                       @"http://7b1gcw.com1.z0.glb.clouddn.com/20150529120500960.mp4",nil];
    
    self.dataArray = phoneColumnlist;
}


#pragma mark - DataSource

- (NSInteger)numberOfItems
{
    return self.dataArray.count+1;
}

- (EUBaseModel *)modelForItemAtRow:(NSInteger)row
{
    EUBaseModel *dataModel = nil;
    if (row < self.dataArray.count)
    {
        dataModel = [[EUBaseModel alloc] init];
        NSString *urlStr = [self.dataArray objectAtIndex:row];
        dataModel.resourceUrl = urlStr;
        
        if ([dataModel.resourceUrl rangeOfString:@"mp4"].length >0)
        {
            dataModel.cellType = CellTypeVideo;
        }
        else if ([dataModel.resourceUrl rangeOfString:@"jpg"].length >0)
        {
            dataModel.cellType = CellTypeImage;
        }
        else
        {
            dataModel.cellType = CellTypeWeb;
        }
    }
    else
    {
        EUMediaModel* specDataModel = [[EUMediaModel alloc] init];
        [specDataModel setCellClass:[EUMediaViewCell class]];
        specDataModel.videoUrl = @"http://7b1gcw.com1.z0.glb.clouddn.com/20150529120500960.mp4";
        specDataModel.imageUrl =@"http://s.cn.bing.net/az/hprichbg/rb/WaterliliesYuanmingyuan_ZH-CN10533925188_1920x1080.jpg";
        specDataModel.webUrl =@"http://www.bing.com";
        return specDataModel;
    }
    
    return dataModel;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    // 内部自己处理视图
    _showCycleView.frame = CGRectMake(0, 0, size.width, size.height);
    [_showCycleView willTransitionToSize:size];
}


- (void)pageView:(EUPageView *)pageView willDisplayCell:(EUPageViewCell *)cell forItemAtRow:(NSInteger)row
{
  // cell will appear
}

- (void)pageView:(EUPageView *)pageView didEndDisplayingCell:(EUPageViewCell *)cell forItemAtRow:(NSInteger)row
{
 // cell didEnd display
}

@end
