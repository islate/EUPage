//
//  EUMediaViewCell.m
//  EUPageExample
//
//  Created by wangliqun on 15/6/1.
//  Copyright (c) 2015年 wangliqun. All rights reserved.
//

#import "EUMediaViewCell.h"
#import "EUMediaModel.h"

@implementation EUMediaViewCell

-(void)loadDataWithModel:(EUBaseModel *)model
{
    [super loadDataWithModel:model];
    if (!self.isUILoad)
    {
        UIWebView *awebView = [[UIWebView alloc] init];
        awebView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:awebView];
        self.webView = awebView;
        
        SlateWebImageView *imageView = [[SlateWebImageView alloc] init];
        imageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:imageView];
        self.smallimageView = imageView;
        
        SlateWebImageView *videoImageView = [[SlateWebImageView alloc] init];
        videoImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:videoImageView];
        self.videoImageView = videoImageView;
        self.isUILoad = YES;
    }
    
    self.webView.frame  = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);
    self.smallimageView.frame = CGRectMake(self.bounds.size.width/2, self.bounds.size.height/2, self.bounds.size.width/2, self.bounds.size.height/2);
    self.videoImageView.frame = CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width/2, self.bounds.size.height/2);
    
    if ([model isKindOfClass:[EUMediaModel class]])
    {
        EUMediaModel *data = (EUMediaModel *)model;
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:data.webUrl]]];
        [self.smallimageView setImageWithURL:[NSURL URLWithString:data.imageUrl]];
        [self.videoImageView setVideoWithURL:[NSURL URLWithString:data.videoUrl] coverImageURL:nil];
        [self.videoImageView play];
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    if (self.videoImageView)
    {
        [self.videoImageView stop];
        [self.videoImageView setMuted:YES];
        [self.videoImageView setVideoWithURL:nil coverImageURL:nil];
    }
    
    if (self.smallimageView)
    {
        [self.smallimageView setImageWithURL:nil];
    }
    
    if (self.webView.isLoading)
    {
        [self.webView stopLoading];
    }
}

- (void)updateSubViewSize:(CGSize)size
{
    self.webView.frame  = CGRectMake(0, 0, size.width, size.height/2);
    self.smallimageView.frame = CGRectMake(size.width/2, size.height/2, size.width/2, size.height/2);
    self.videoImageView.frame = CGRectMake(0, size.height/2, size.width/2, size.height/2);
}

@end
