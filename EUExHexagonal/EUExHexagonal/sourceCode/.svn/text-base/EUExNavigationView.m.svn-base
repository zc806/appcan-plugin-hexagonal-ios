//
//  LEAppCenterView.m
//  AppCan
//
//  Created by AppCan on 12-12-12.
//  Copyright (c) 2012年 AppCan. All rights reserved.
//

#import "EUExNavigationView.h"
#import <QuartzCore/QuartzCore.h>
#import "EUExHexagonal.h"
#import "iCarousel.h"
#import "ReflectionView.h"
#import "BBCyclingLabel.h"

@interface EUExNavigationView ()<iCarouselDataSource, iCarouselDelegate>{
    
}

@property (nonatomic, retain) NSMutableArray* dataArray;
@property (nonatomic, retain) NSMutableArray* nameArray;
@property (nonatomic, retain) iCarousel *carousel;

@end

@implementation EUExNavigationView
@synthesize carousel;
@synthesize dataArray;

#pragma mark -
#pragma mark View lifecycle

- (UIImage *)getImageFromLocalFile:(NSString*)imageName{
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
}

- (UIImage *)getImageFromLocalFile_jpg:(NSString*)imageName{
	return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"]];
}

//创建列表
-(void)initSelfView:(CGRect)frame jsonDict:(NSMutableDictionary *)jsonDict{
    float x,y,width,height;
    
    //本地图片
    if ([jsonDict isKindOfClass:[NSMutableDictionary class]]) {
        isSetPrismParam = YES;
        self.dataArray = [NSMutableArray arrayWithCapacity:0];
        self.nameArray = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *array = [jsonDict objectForKey:@"value"];
        for (NSMutableDictionary *dict in array) {
            NSString *pic = [dict objectForKey:@"pic"];
            if ([pic isKindOfClass:[NSString class]] && pic.length>0) {
                [self.dataArray addObject:pic];
            }else{
                [self.dataArray addObject:@""];
            }
            NSString *text = [dict objectForKey:@"text"];
            if ([text isKindOfClass:[NSString class]] && text.length>0) {
                [self.nameArray addObject:text];
            }else{
                [self.nameArray addObject:@""];
            }
        }
    }else{
        isSetPrismParam = NO;
        self.dataArray = [NSMutableArray arrayWithObjects:
                          @"uexHexagonal/one",
                          @"uexHexagonal/two",
                          @"uexHexagonal/three",
                          @"uexHexagonal/four",
                          @"uexHexagonal/five",
                          @"uexHexagonal/six",
                          nil];
        self.nameArray = [NSMutableArray arrayWithObjects:
                          @"北京市国家税务局",
                          @"发票查询",
                          @"出口退税",
                          @"代开发票",
                          @"网上认证",
                          @"网上抄报税",
                          nil];
    }
    //create carousel、configure carousel
    x=frame.origin.x; y=frame.origin.y; width=frame.size.width; height=frame.size.height;
	carousel = [[iCarousel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    carousel.backgroundColor=[UIColor clearColor];
	carousel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    carousel.type = iCarouselTypeCylinder;
    //decelerationrate 好象只能设置当它减速时的速度,0.1f的话,很快就停下来,1就正常速度停下,即滑动一定距离才停.
    carousel.decelerationRate=0.96; //拖动速度
    carousel.stopAtItemBoundary=NO; //控制视图不每次停留在正中间 有一个动画移动缓冲
    //carousel.scrollToItemBoundary=NO; //控制视图转动多少就停留多少角度
    //carousel.centerItemWhenSelected=NO; //控制视图 只有中间的视图可点击
	carousel.delegate = self;
	carousel.dataSource = self;
    //视点偏移量 默认（0,0)
    CGSize offset_viewpoint = CGSizeMake(0.0f, 0.0f);
    carousel.viewpointOffset = offset_viewpoint;
    //内容视图偏移量 默认（0,0) 在中心
    CGSize offset_content = CGSizeMake(0.0f, -30.0f);
    carousel.contentOffset = offset_content;
    //add carousel to view
	[self addSubview:carousel];
    
    //箭头
    width=10; height=20; x=(frame.size.width-width)/2.0; y=frame.size.height-30-height;
    UIImageView* jiantou_imgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    jiantou_imgView.backgroundColor=[UIColor clearColor];
    [jiantou_imgView setImage:[self getImageFromLocalFile:@"uexHexagonal/jiantou"]];
    [self addSubview:jiantou_imgView];
    [jiantou_imgView release];
    
    //文本
    x=frame.origin.x; y=frame.size.height-30; width=frame.size.width; height=30;
    BBCyclingLabel* titleLabel=[[BBCyclingLabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
    titleLabel.transitionEffect = BBCyclingLabelTransitionEffectScaleFadeIn;
    [titleLabel setTag:1001];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setBaselineAdjustment:UIBaselineAdjustmentAlignCenters];
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_0
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
#else
    [titleLabel setTextAlignment:UITextAlignmentCenter];
#endif
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [self addSubview:titleLabel];
    [titleLabel release];
}

-(id)initWithFrame:(CGRect)frame jsonDict:(NSMutableDictionary *)jsonDict EUExHexagonal:(EUExHexagonal *)uexBase{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        self.eUExNavigation = uexBase;
        //列表
        [self initSelfView:CGRectMake(0, 0, frame.size.width, frame.size.height) jsonDict:jsonDict];
    }
    return self;
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    //normally we'd use a backing array
    if (self.dataArray) {
        return [self.dataArray count];
    }
    return 0;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(ReflectionView *)view{
    //PluginLog(@"<<Chao-->iCarouselExampleViewController-->carousel:viewForItemAtIndex:reusingView:-->index:%d",index);
	UIImageView *imageView = nil;
	//create new view if no view is available for recycling
	if (view == nil){
        //set up reflection view
		view = [[[ReflectionView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 170.0f, 223.0f)] autorelease];
        
        //异步加载类 设定图片的URL图片会在下载完成后 自动加载
		imageView = [[UIImageView alloc] initWithFrame:view.bounds];
        imageView.backgroundColor=[UIColor clearColor];
        imageView.tag = 9999;
        imageView.frame = view.bounds;
        [view addSubview:imageView];
        [imageView release];
        
        UIImageView* shadow_imgView = [[UIImageView alloc] initWithFrame:view.bounds];
        shadow_imgView.tag = 9998;
        [shadow_imgView setHidden:NO];
        [shadow_imgView setImage:[self getImageFromLocalFile:@"uexHexagonal/shadow"]];
        shadow_imgView.backgroundColor=[UIColor clearColor];
        [view addSubview:shadow_imgView];
        [shadow_imgView release];
        
        //如果不是循环显示的话 默认显示index为1
        if (self.carousel.wrapEnabled) {
            
        }else {
            if (index==1 && [self.dataArray count]>=3) {
                [self.carousel scrollToItemAtIndex:1 animated:YES];
            }
        }
	}else{
        //(*****)注意此步骤一定要有 因为视图在加载使用了缓存机制
        //比如self.dataArray=100，但是及的视图（iCarouselOptionFadeRange）可能只有有限的几个 所以时每次都在使用重复的view 显示不同的内容！
        imageView=(UIImageView*)[view viewWithTag:9999];
        [self hiddenShadow:NO with_view:view];
	}
    
    //set image
    if (imageView) {
        //(1)直接设置本地图片
        NSString *path = [self.dataArray objectAtIndex:index];
        if (isSetPrismParam) {
            path = [EUtility getAbsPath:self.eUExNavigation.meBrwView path:path];
            imageView.image = [UIImage imageWithContentsOfFile:path];
        }else{
            imageView.image = [self getImageFromLocalFile:path];
        }
    }
	
	return view;
}

//视图操作回调函数
- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option){
            //是否循环
        case iCarouselOptionWrap: {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        default:{
            return value;
        }
    }
}

//选择某一产品后 进入产品详情
- (void)carousel:(iCarousel *)aCarousel didSelectItemAtIndex:(NSInteger)index{
	//点击正中间的产品 进入到下一个界面
    if (self.carousel.currentItemIndex==index) {
        if (self.eUExNavigation!=nil && [(NSObject*)self.eUExNavigation respondsToSelector:@selector(naviClicked:)]) {
            [self.eUExNavigation naviClicked:[NSNumber numberWithInt:index]];
        }
    }
}

-(void)update_ReflectionView:(ReflectionView*)view{
    if (view) {
        [view update];
    }
}

-(void)hiddenShadow:(BOOL)isShowBool with_view:(ReflectionView*)view{
    if (view!=nil && [view isKindOfClass:[ReflectionView class]]==YES) {
        UIImageView* shadow_imgView = (UIImageView*)[view viewWithTag:9998];
        if (shadow_imgView) {
            // Place the snap shot to it's final position and fade it out
			[UIView animateWithDuration:0.4
							 animations:^{
                                 if (isShowBool) {
                                     [shadow_imgView setAlpha:0.0];
                                 }else{
                                     [shadow_imgView setAlpha:1.0];
                                 }
							 }
							 completion:^(BOOL finished) {
                                 
                             }];
        }
    }
}


- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    [self hiddenShadow:YES with_view:(ReflectionView*)self.carousel.currentItemView];
}

//更新倒影
-(void)update_three_visibleItemViews{
    NSAutoreleasePool * pool =[[NSAutoreleasePool alloc] init];
    
    //动画结束后 更新当前的倒影
    [self hiddenShadow:YES with_view:(ReflectionView*)self.carousel.currentItemView];
    [self update_ReflectionView:(ReflectionView*)self.carousel.currentItemView];
    
    int i=0;
    for (; i<[self.carousel.visibleItemViews count]; i++) {
        ReflectionView* indexView=(ReflectionView*)[self.carousel.visibleItemViews objectAtIndex:i];
        if ([indexView isEqual:self.carousel.currentItemView]) {
            break;
        }
    }
    //更新倒影 当前视图的上一个视图
    int lastViewIndex;
    if (i==0) {
        lastViewIndex=[self.carousel.visibleItemViews count]-1;
    }else {
        lastViewIndex=i-1;
    }
    if ([self.carousel.visibleItemViews count]>lastViewIndex) {
        ReflectionView* lastView=(ReflectionView*)[self.carousel.visibleItemViews objectAtIndex:lastViewIndex];
        [self update_ReflectionView:lastView];
    }
    //更新倒影 当前视图的上一个视图
    int nextViewIndex;
    if (i==[self.carousel.visibleItemViews count]-1) {
        nextViewIndex=0;
    }else {
        nextViewIndex=i+1;
    }
    if ([self.carousel.visibleItemViews count]>nextViewIndex) {
        ReflectionView* nextView=(ReflectionView*)[self.carousel.visibleItemViews objectAtIndex:nextViewIndex];
        [self update_ReflectionView:nextView];
    }
    
    //更新阴影
    for (ReflectionView* view in self.carousel.visibleItemViews) {
        if ([view isEqual:self.carousel.currentItemView]==NO) {
            [self hiddenShadow:NO with_view:view];
        }
    }
    
    [pool release];
}

//延迟调用 以防止实时更新显示不正确
-(void)delay_update_Label:(NSString*)functionStr{
    //get item index
	NSInteger index = [self.carousel currentItemIndex];
    if (index<[self.nameArray count]) {
        BBCyclingLabel* titleLabel=(BBCyclingLabel*)[self viewWithTag:1001];
        if (titleLabel) {
            [titleLabel setText:[self.nameArray objectAtIndex:index] animated:YES];
        }
    }
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    [self hiddenShadow:NO with_view:(ReflectionView*)self.carousel.currentItemView];
}

- (void)carouselWillBeginDecelerating:(iCarousel *)carousel{
    [self hiddenShadow:NO with_view:(ReflectionView*)self.carousel.currentItemView];
}

//一下函数随着滚动或动画结束 更新下方的页面指示器
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    
    //新启动线程去更新阴影
    [NSThread detachNewThreadSelector:@selector(update_three_visibleItemViews) toTarget:self withObject:nil];
	[self performSelector:@selector(delay_update_Label:) withObject:@"carouselDidEndScrollingAnimation:" afterDelay:0.1];
}
- (void)carouselDidEndDragging:(iCarousel *)aCarousel willDecelerate:(BOOL)decelerate{
	
}
- (void)carouselDidEndDecelerating:(iCarousel *)aCarousel{
    
}

#pragma mark -
#pragma mark Memory

- (void)dealloc {
	carousel.delegate = nil;
    carousel.dataSource = nil;
    if (self.carousel) {
        self.carousel=nil;
    }
    if (self.dataArray) {
        self.dataArray=nil;
    }
    if (self.nameArray) {
        self.nameArray=nil;
    }
    
    [super dealloc];
}

@end
