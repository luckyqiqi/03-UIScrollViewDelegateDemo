//
//  ViewController.m
//  03-UIScrollViewDelegateDemo
//
//  Created by qingyun on 16/5/10.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //contentSize
    _scrollView.contentSize = CGSizeMake(375, 667);
    //设置代理
    _scrollView.delegate = self;
    
    
    //缩放
    
    //设置缩放的比例范围
    _scrollView.maximumZoomScale = 1.5;
    _scrollView.minimumZoomScale = 0.5;
    
    //缩放反弹效果
    _scrollView.bouncesZoom = NO;
    
    //属性控制滚动至顶部
    _scrollView.scrollsToTop = YES;
    
    //动态更改scrollView的contentOffset
    [_scrollView setContentOffset:CGPointMake(0, 100) animated:NO];
    
    // Do any additional setup after loading the view, typically from a nib.
}
#if 1
#pragma mark -UIScrollViewDelegate (移动)
//时刻监听scrollView的内容的偏移量(常用于,下拉 刷新的时候,启动刷新动画)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    //NSLog(@"%s",__func__);
}

//将要开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //NSLog(@"%s",__func__);
}

//将要结束拖动
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    //NSLog(@"%s",__func__);
    NSLog(@"targetContentOffset:%@",NSStringFromCGPoint(*targetContentOffset));
    *targetContentOffset = CGPointMake(0, 50);
}

//已经结束拖动,将要开始减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //NSLog(@"%s",__func__);
}

//将要开始减速
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    //NSLog(@"%s",__func__);
}

//已经完成减速(常用于:当减速完成之后,通过偏移量来计算当前页码,展示在pageControl上)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   //NSLog(@"%s",__func__);
    NSLog(@"DidEndDecelerating:%@",NSStringFromCGPoint(scrollView.contentOffset));
}
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating
//当调用setContentOffset/scrollRectVisible:animated:,并且带有动画的调用的时候,被调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"%s",__func__);
}
#else
#pragma mark  -UIScrollViewDelegate (缩放)

//指定缩放的视图(注意:scrollView缩放时,必须实现的委托方法)
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

//时刻监听_scrollView内容视图的缩放比例
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.zoomScale);
}

//将要开始缩放
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view {
    NSLog(@"%s",__func__);
}

//已经结束缩放 (反弹效果之后,被调用)
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale {
    NSLog(@"%s",__func__);
}
#endif

//允许滚动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    return NO;
}
//滚动至顶部之后,需要做的操作(比如:进行网络请求,刷新界面)
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    NSLog(@"获取新数据,刷新界面");
}
@end
