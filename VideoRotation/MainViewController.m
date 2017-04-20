//
//  MainViewController.m
//  VideoRotation
//
//  Created by lifan on 2017/4/19.
//  Copyright © 2017年 lifan. All rights reserved.
//

#import "MainViewController.h"

#define PORTRAITVIDEOFRAME CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.width * 0.5)
@interface MainViewController ()
@property (nonatomic,strong) UIImageView *videoImageView;
@property (nonatomic,assign) UIInterfaceOrientation currentInterfaceOrientation;
@end

@implementation MainViewController

- (BOOL)shouldAutorotate {
    //这个必须为NO 才能强制调整statusbar方向
    return NO;
}
- (void)dealloc
{
    //移除重力感应监听
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIDeviceOrientationDidChangeNotification
                                                  object:nil];
    
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _videoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"movie"]];
    [self.view addSubview:_videoImageView];
    _videoImageView.frame = PORTRAITVIDEOFRAME;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction)];
    _videoImageView.userInteractionEnabled = YES;
    [_videoImageView addGestureRecognizer:tap];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleDeviceOrientationDidChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    _currentInterfaceOrientation = UIInterfaceOrientationPortrait;
    
}
- (void)handleDeviceOrientationDidChange:(UIInterfaceOrientation)interfaceOrientation{
    UIDevice *device = [UIDevice currentDevice] ;
    switch (device.orientation) {
        case UIInterfaceOrientationPortrait:
        {
            [self videoRotateWithOrientation:UIInterfaceOrientationPortrait];
            _currentInterfaceOrientation = UIInterfaceOrientationPortrait;
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
           [self videoRotateWithOrientation:UIInterfaceOrientationLandscapeRight];
            _currentInterfaceOrientation = UIInterfaceOrientationLandscapeRight;

        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            [self videoRotateWithOrientation:UIInterfaceOrientationLandscapeLeft];
             _currentInterfaceOrientation = UIInterfaceOrientationLandscapeLeft;
    
        }
            break;
        default:{
            
        }
            break;
    }
    
}


- (void)handleTapAction{
    if ( MAX(_videoImageView.bounds.size.width, _videoImageView.bounds.size.height) == MAX([UIApplication sharedApplication].keyWindow.bounds.size.width, [UIApplication sharedApplication].keyWindow.bounds.size.height)) {//当前是全屏状态
        [self videoRotateWithOrientation:UIInterfaceOrientationPortrait];
        
    }else{ //  当前是小屏状态
        switch (_currentInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            [self videoRotateWithOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:
        {
           [self videoRotateWithOrientation:UIInterfaceOrientationLandscapeRight];
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
              [self videoRotateWithOrientation:UIInterfaceOrientationLandscapeLeft];
        }
            break;
        default:
            break;
    }
        
}
    
}

- (void)videoRotateWithOrientation:(UIInterfaceOrientation)interfaceOrientation{
    CGFloat pi;
    CGRect frame =  [UIApplication sharedApplication].keyWindow.bounds;
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        pi = -M_PI_2;
        
    }else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight){
        pi = M_PI_2;
        
    }else{
        frame = PORTRAITVIDEOFRAME;
        pi = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _videoImageView.transform = CGAffineTransformMakeRotation(pi);
        _videoImageView.frame = frame;
        [[UIApplication sharedApplication].keyWindow addSubview:_videoImageView];
    } completion:nil];

    [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
