//
//  ViewController.m
//  Block循环引用
//
//  Created by ~~浅笑 on 16/8/4.
//  Copyright © 2016年 广东康爱多连锁药店有限公司. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

@interface ViewController ()<SetBackgroundColorDelegate>

@property (nonatomic,strong) TestViewController * testViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickBtn1:(id)sender {
    [self push];
}

- (IBAction)clickBtn2:(id)sender {
    [self push];
}

- (IBAction)clickBtn3:(id)sender {
//    [self push];
    
    _testViewController = [[TestViewController alloc] init];
    _testViewController.delegate = self;
    [self.navigationController pushViewController:_testViewController animated:YES];
}

-(void)push{
    TestViewController * testVC = [[TestViewController alloc] init];
    testVC.delegate = self;
    [self.navigationController pushViewController:testVC animated:YES];
}

-(void)setBackgroundColor:(UIColor *)color{
    self.view.backgroundColor = color;
}
@end
