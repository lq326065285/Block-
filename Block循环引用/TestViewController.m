//
//  TestViewController.m
//  Block循环引用
//
//  Created by ~~浅笑 on 16/8/4.
//  Copyright © 2016年 广东康爱多连锁药店有限公司. All rights reserved.
//

#import "TestViewController.h"

#import "TestModel1.h"

@interface TestViewController ()

@property (nonatomic,strong) TestModel1 * model1;

@property (nonatomic,strong) TestModel1 * model2;

@property (nonatomic,weak) TestModel1 * model3;

@property (nonatomic,strong) NSMutableArray * data;

@property (nonatomic,strong) NSString * name;

@property (nonatomic,copy) id block;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSTimer * t = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    [self example3];
}

-(void)example1{
    self.model1 = [[TestModel1 alloc] init];
    //block是局部变量所以不会有循环引用问题
    [self.model1 getMyBlock:^{
        [self.data addObject:@"1"];
    }];
    
    //block是self.model1的属性，所以会有循环引用问题
    [self.model1 testBlock:^{
        self.name = @"qiang";
    }];
}

-(void)example2{
    //由于m是一个局部变量，所以此处也不会有循环引用
    TestModel1 * m = [TestModel1 shareTestModelWithBlock:^{
       self.name = @"qiang";
    }];

    //由于self.model2是属性，并且为strong,所以会有循环引用问题
    self.model2 = [TestModel1 shareTestModelWithBlock:^{
        self.name = @"qiang";
    }];
    
    //由于self.model3是属性，并且为weak,所以不会有循环引用问题
    self.model3 = [TestModel1 shareTestModelWithBlock:^{
        self.name = @"qiang";
    }];
    
}

-(void)example3{
//    __block TestViewController * blockSelf = self;
//    self.model2 = [TestModel1 shareTestModelWithBlock:^{
//        blockSelf.name = @"qiang";
//    }];
    
//    self.model2 = [[TestModel1 alloc] init];
//    self.model2.myBlock = ^(){
//        self.name = @"qiang";
//    };
//
    
//    MLeaksFinder检测不出来内存泄漏，但是instrument可以检查出来
    TestModel1 * t = [[TestModel1 alloc] init];
    __weak typeof(t)weakT = t;
    [t testBlock:^{
        weakT.name = @"l";
        if([weakT.name isEqualToString:@""]){
            NSLog(@"hh");
        }
    }];
    
    
//    TestModel1 * t = [[TestModel1 alloc] init];
//    [t testBlock:^{
//        t.name = @"l";
//        if([t.name isEqualToString:@""]){
//            NSLog(@"hh");
//        }
//    }];
}

-(void)example4{
//    __weak typeof(self)weakSelf = self;
    self.block = ^{
        [_data addObject:@"1"];
    };
    
    self.block = ^{
//        [self.data addObject:@"1"];
    };
}

-(void)example5{
    void(^MyBlock)() = ^{
        self.name = @"qiang";
    };
    
    MyBlock();
    NSLog(@"name:%@",self.name);
}

- (IBAction)clickBackColor:(id)sender {
    if ([self.delegate respondsToSelector:@selector(setBackgroundColor:)]) {
        [self.delegate setBackgroundColor:[UIColor grayColor]];
    }
}

#pragma mark -

-(NSMutableArray *)data{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}


-(void)dealloc{
    NSLog(@"TestViewController delloc");
}

-(void)timerAction:(NSTimer*)timer{

}

@end
