## 通用文章页组件项目总结
### 项目介绍
 目前文章页模块的主要功能是用来展示Html, Picture，Video，Pdf等格式的文件，手动实现了页面的展示，循环，重用逻辑。随着iOS 版本的不断迭代，功能和控件也在不断丰富，在经过一系列的技术调研后，发现已经有更好技术来实现该功能。
 
本项目主要是为了解决一般的内容展示需求，本项目在UICollectionView 的基础上，对其进行扩展，封装，目前能够很好的解决html, picture，video 不同类型的内容展示需求，同时具有很好扩展性能。
本项目的功能点主要有以下几点：
* 默认支持展示网页，图片，视频的展示。
* 可以手动设置是否支持循环展示。
* 支持展示内容扩展，可自由定制显示内容。
* 丰富的代理，可以控制内容展示前后的操作。
* 在显示大量数据时具有较低的内存占用的特点。

### 安装指南
 建议使用[CocoaPods](http://cocoapods.org)来安装EUPage，请加入以下这行到你的`Podfile`:

```ruby
pod 'EUPage'
```
     
### 使用指南
####  框架基本结构介绍
 
* EUPageView : 对CollectionView 的封装，对外提供了接口，经过简单的配置后就可以展示指定类型的内容。
* EUPageViewCell :抽象cell,有扩展需求的时候可以继承该类实现自定义内容的展示。 
* EUBaseModel :dataModel 主要是用来组织需要显示的数据的结构
  ![Alt text](http://7fvh6h.com1.z0.glb.clouddn.com/blog71EA7F8C-B058-49F0-8135-2B7BEA6CC7A0.png)


####  框架接入步骤
* **在必要的类型中引入 头文件** 
```
#import <EUPage/EUPage.h>
```
*  **创建实例**
```
EUPageView *_showCycleView = [[EUPageView alloc] initWithFrame:self.view.bounds scrollDirection:UICollectionViewScrollDirectionHorizontal];
    _showCycleView.delegate = self;
    _showCycleView.dataSource = self;
    _showCycleView.needCycleShow = YES;
    [self.view addSubview:_showCycleView];
```
>  注： scrollDirection有两个方向可以设置对应 竖直方向和水平方向滚动。

*  **实现相关的代理**
 
 ` DataSource` 
 ```
   // 数据的个数
   - (NSInteger)numberOfItems  
   // 组织数据源
  - (EUBaseModel *)modelForItemAtRow:(NSInteger)row：

 ```

  `Delegate`
  
 ```
 // cell 在显示前的操作可以在此处实现
 - (void)pageView:(EUPageView *)pageView willDisplayCell:(EUPageViewCell *)cell forItemAtRow:(NSInteger)row;
 // cell 在显示后的操作可以在此处实现
  - (void)pageView:(EUPageView *)pageView didEndDisplayingCell:(EUPageViewCell *)cell forItemAtRow:(NSInteger)row;
 ```
* 使用通用Cell 和自定义Cell 的设置
 (1)使用框架默认提供的Cell
  实现在第一页展示一张图片的model
 ```
 - (EUBaseModel *)modelForItemAtRow:(NSInteger)row
   {
       if（row==0）
     {
         EUBaseModel *dataModel = [[EUBaseModel alloc] init];
        dataModel.resourceUrl =    @"http://c.hiphotos.baidu.com/image/pic/item/622762d0f703918f925bf2cd533d269759eec42b.jpg";
   dataModel.cellType = CellTypeImage;
       }
    }
 ```
 这样就可以在第一页显示一张图片了
 > 在使用框架自带Cell 时，只需要通过cellType 告诉系统展示的类型的类型，而自定义的cell 则是使用setCellClass 方法。
 
 (2 )使用自定义Cell

 **实现在同一个页面展示视频，网页，图片功能的cell**
 
   `扩展数据Model,加入对应资源的地址（这个Model 必须是EUBaseModel 的子类`

   ```
 @interface EUMediaModel : EUBaseModel
 @property (nonatomic, strong)NSString * videoUrl;
 @property (nonatomic, strong)NSString * webUrl;
 @property (nonatomic, strong)NSString * imageUrl;
   ```

  
 ` 实现自定义cell(这个cell应该是 EUPageViewCell的一个子类)`

     扩展成员属性
     
    ```
    @interface EUMediaViewCell : EUPageViewCell
@property (nonatomic, assign)BOOL isUILoad;
@property (nonatomic, strong)UIWebView         *webView;
@property (nonatomic, strong)SlateWebImageView *smallimageView;
@property (nonatomic, strong)SlateWebImageView *videoImageView;
@end
    ```

   `自定义内容的初始化，和布局的实现`
   
   ```
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
   ```
   
    `dataSource 回调代码`

      特别要注意，在使用自定义的cell的cell 时应该调用方法： setCellClass 。参数应该是上文中自定义的Cell 

    ```
       - (EUBaseModel *)modelForItemAtRow:(NSInteger)row
     {
         if（row==1）
         {
        EUMediaModel* specDataModel = [[EUMediaModel alloc] init];
        [specDataModel setCellClass:[EUMediaViewCell class]];
        specDataModel.videoUrl = @"http://debug.bbwc.cn/uploadfile/video/iweekly_android/2015/05/29/20150529120500960/20150529120500960.mp4";
        specDataModel.imageUrl =@"http://c.hiphotos.baidu.com/image/pic/item/622762d0f703918f925bf2cd533d269759eec42b.jpg";
        specDataModel.webUrl =@"http://content.cdn.bb.bbwc.cn/v5/app1/issue_1129/articles/10056555/show-1-6-1129-304-10056555-1_1433397639.html";
        return specDataModel;
        }
    }
    ```

* **处理旋转**
  
  对于有支持多方向展示需求的的APP还需要在设备旋转时，正确的实现下面的方法
  代码参考
   ```
   
 (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    // 内部自己处理视图
    _showCycleView.frame = CGRectMake(0, 0, size.width, size.height);
    [_showCycleView updateSubViewFrame:size];
}
``` 


 
 
###  DEMO展示

本项目自带了一个Demo ,简单的实现了一些内容的展示，具体功能点如下
* 展示了如何组织数据源，使用框架提供的控件展示视频，图片，网页 （每页只展示一种类型内容）。
* 展示了一个 自定义的Cell和Model 在一个页面上同时展示视频，图片，网页
* 展示了如何处理旋转。

git 地址（可以在浏览器输入地址查看：http://7fvh6h.com1.z0.glb.clouddn.com/blogdebug3.gif）：
![使用图片介绍](http://7fvh6h.com1.z0.glb.clouddn.com/blogdebug3.gif)
