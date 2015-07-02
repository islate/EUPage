//
//  ViewController.h
//  EUPageExample
//
//  Created by wangliqun on 15/6/1.
//  Copyright (c) 2015年 wangliqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUPage.h"

@interface ViewController : UIViewController<EUPageViewDataSource,EUPageViewDelegate>
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)EUPageView *showCycleView;

@end

