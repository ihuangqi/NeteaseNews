//
//  TestViewController.m
//  NeteaseNews
//
//  Created by 004 on 15/6/30.
//  Copyright (c) 2015年 新果. All rights reserved.
//

#import "TestViewController.h"
#import "CalendarViewController.h"

#define kViewCount 20

@interface TestViewController ()
@property(nonatomic, strong) UIImageView *imageView;
@end
@implementation TestViewController
{
    CAReplicatorLayer *repl;
    CAReplicatorLayer *replicator;
    int _currentIndex;

    UIImageView *imageView;
    CAReplicatorLayer *repl2;
}
- (void)viewDidLoad
{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(150, 410, 50, 50)];
    imageView.image = [UIImage imageNamed:@"biz_media_subscribed_list_item_delete_pressed"];

    [self initImageView2];


    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"日历" style:UIBarButtonItemStylePlain target:self action:@selector(gotoCalendarViewController:)];
    self.navigationItem.rightBarButtonItem = barButton;

    [self initImageView];
    [self initAnimation];

}
-(void)initAnimation{
//    [repl removeAllAnimations];
    [repl removeFromSuperlayer];
    repl = [CAReplicatorLayer layer];
    [self.imageView.layer addSublayer:repl];
    repl.frame = self.imageView.bounds;

    // 一般层
    CALayer *layer = [CALayer layer];
    //    layer.anchorPoint = CGPointMake(0.5, 1);
    // 一开始不想显示的话就先隐藏
    //    layer.transform = CATransform3DMakeScale(0, 0, 0);
    layer.frame = CGRectMake((self.imageView.bounds.size.width - 20) / 2, 0, 20, 20);

    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.cornerRadius = 10;
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @(1);
    anim.toValue = @(-1);
    anim.repeatCount = MAXFLOAT;
    CGFloat duraton = 1;
    anim.duration = duraton;

    [layer addAnimation:anim forKey:nil];
    [repl addSublayer:layer];
    repl.instanceCount = kViewCount;
    CGFloat angle = M_PI * 2 / kViewCount;
    repl.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    repl.instanceDelay = duraton / kViewCount * 2;

    [self createLayerWithColor:[UIColor blueColor] anchorPoint:CGPointMake(0.5, 1)];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initAnimation];
}
-(void)viewDidAppear:(BOOL)animated{



}

- (void)createLayerWithColor:(UIColor *)color anchorPoint:(CGPoint)point{
    // 复制图层 CAReplicatorLayer
    [replicator removeFromSuperlayer];
    replicator = [CAReplicatorLayer layer];

    [self.view.layer addSublayer:replicator];
    // 必须设置尺寸
    replicator.frame = CGRectMake(10, 350, 5, 50);

    // 创建图层
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    // 注意设置锚点和 frame 的顺序 , 先设置锚点再设置位置
    layer.anchorPoint = point;
    layer.frame = replicator.bounds;
    // 添加图层动画
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"transform.scale.y";  // 只改变 y 值
    anim.fromValue = @(0);
    anim.toValue = @(1);
    anim.repeatCount = MAXFLOAT;
    anim.duration = 2;
    anim.autoreverses = YES;  // 自动反转动画
    [layer addAnimation:anim forKey:nil];
    // 将图层添加到复制图层
    [replicator addSublayer:layer];
    // 复制图层总个数，包括原图层
    replicator.instanceCount = 10;
    // 图层之间显示的延迟
    replicator.instanceDelay = 0.2;
    // 图层之间的距离或者其他属性
    replicator.instanceTransform = CATransform3DMakeTranslation(8, 0, 0);
    // 如果设置了原始层背景色，就不需要设置这个属性
    replicator.instanceRedOffset = -0.4;



}

- (void)buttonClicked:(UIButton *)sender {
    [UIView beginAnimations:@"" context:nil];
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform,M_PI);
    self.imageView.animationDuration = 10;
    self.imageView.animationRepeatCount = 1;
    [UIView commitAnimations];
}

- (void)initImageView {
    //定义图片控件
    _imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 300)];
//    _imageView.frame=[UIScreen mainScreen].applicationFrame;
    _imageView.contentMode=UIViewContentModeScaleAspectFill;
    _imageView.image=[UIImage imageNamed:@"biz_ad_new_version1_img1.jpg"];//默认图片
    _imageView.clipsToBounds = YES;
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];

    //添加手势
    UISwipeGestureRecognizer *leftSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    leftSwipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [_imageView addGestureRecognizer:leftSwipeGesture];

    UISwipeGestureRecognizer *rightSwipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    rightSwipeGesture.direction=UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:rightSwipeGesture];


}
- (void)initImageView2{

    repl2 = [CAReplicatorLayer layer];
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"biz_media_subscribed_list_item_delete_pressed"].CGImage;

    repl2.backgroundColor = [UIColor whiteColor].CGColor;
    layer.frame = imageView.bounds;
        repl2.anchorPoint = CGPointMake(0.5, 0.5);
    repl2.frame = CGRectMake(imageView.frame.origin.x - imageView.frame.size.width, imageView.frame.origin.y, imageView.frame.size.width * 2, imageView.frame.size.height * 2);
    [repl2 addSublayer:layer];


    repl2.instanceCount = 4;
     CGFloat angel = M_PI_2;
//    for (int i= 3; i >= 0; i--) {
//        angel = i*M_PI_2;
//        CATransform3D transform = CATransform3DMakeTranslation(imageView.frame.size.width/2, 0 , 0);
//        transform = CATransform3DRotate(repl2.transform, angel, 0, 0, 1);
//        repl2.instanceTransform = transform;
//    }
    repl2.instanceTransform = CATransform3DRotate(repl2.transform, angel, 0, 0, 1);
//    CATransform3D transform = CATransform3DMakeTranslation(-imageView.frame.size.width, imageView.frame.size.height , 0);
//    transform = CATransform3DRotate(transform, M_PI_2, 0, 0, 1);
//    CGFloat angle = M_PI_2;
//    repl2.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    repl2.instanceRedOffset = -0.1;
    repl2.instanceGreenOffset = -0.1;
    repl2.instanceBlueOffset = -0.1;
    [self.view.layer addSublayer:repl2];
}
#pragma mark 向左滑动浏览下一张图片
-(void)leftSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:YES];
}

#pragma mark 向右滑动浏览上一张图片
-(void)rightSwipe:(UISwipeGestureRecognizer *)gesture{
    [self transitionAnimation:NO];
}


#pragma mark 转场动画
-(void)transitionAnimation:(BOOL)isNext{
    //1.创建转场动画对象
    CATransition *transition=[[CATransition alloc]init];

    //2.设置动画类型,注意对于苹果官方没公开的动画类型只能使用字符串，并没有对应的常量定义
    transition.type=@"cube";

    //设置子类型
    if (isNext) {
        transition.subtype=kCATransitionFromRight;
    }else{
        transition.subtype=kCATransitionFromLeft;
    }
    //设置动画时常
    transition.duration=0.5f;

    //3.设置转场后的新视图添加转场动画
    _imageView.image=[self getImage:isNext];
    [_imageView.layer addAnimation:transition forKey:@"KCTransitionAnimation"];
}

#define IMAGE_COUNT 7
#pragma mark 取得当前图片
-(UIImage *)getImage:(BOOL)isNext{
    if (isNext) {
        _currentIndex=(_currentIndex+1)%IMAGE_COUNT;
    }else{
        _currentIndex=(_currentIndex-1+IMAGE_COUNT)%IMAGE_COUNT;
    }
    NSString *imageName=[NSString stringWithFormat:@"biz_ad_new_version1_img%i.jpg",_currentIndex + 1];
    return [UIImage imageNamed:imageName];
}

- (void)gotoCalendarViewController:(id)sender {
    [self.navigationController pushViewController:[[CalendarViewController alloc] init] animated:YES];
}
@end
