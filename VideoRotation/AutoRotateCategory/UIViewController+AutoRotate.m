//
//  UIViewController+AutoRotate.m
//  sdautolayouttest3
//
//  Created by 李樊 on 16/5/23.
//  Copyright © 2016年 isoushi. All rights reserved.
//

#import "UIViewController+AutoRotate.h"
#import "AppDelegate.h"
@implementation UIViewController (AutoRotate)

- (BOOL)shouldAutorotate{
    
    return YES;
    
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations

{
        return UIInterfaceOrientationMaskPortrait;
    
}



- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation

{
    
    return UIInterfaceOrientationPortrait;
    
}


@end
