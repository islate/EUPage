//
//  EUMediaViewCell.h
//  EUPageExample
//
//  Created by wangliqun on 15/6/1.
//  Copyright (c) 2015年 wangliqun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUPage.h"

@interface EUMediaViewCell : EUPageViewCell

@property (nonatomic, assign)BOOL isUILoad;
@property (nonatomic, strong)UIWebView         *webView;
@property (nonatomic, strong)SlateWebImageView *smallimageView;
@property (nonatomic, strong)SlateWebImageView *videoImageView;

@end
