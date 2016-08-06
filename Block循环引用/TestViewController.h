//
//  TestViewController.h
//  Block循环引用
//
//  Created by ~~浅笑 on 16/8/4.
//  Copyright © 2016年 广东康爱多连锁药店有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SetBackgroundColorDelegate <NSObject>

-(void)setBackgroundColor:(UIColor *)color;

@end

@interface TestViewController : UIViewController

@property (nonatomic,strong) id <SetBackgroundColorDelegate>delegate;

@end
