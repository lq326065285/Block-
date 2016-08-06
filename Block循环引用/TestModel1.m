//
//  TestModel1.m
//  Block循环引用
//
//  Created by ~~浅笑 on 16/8/4.
//  Copyright © 2016年 广东康爱多连锁药店有限公司. All rights reserved.
//

#import "TestModel1.h"



@implementation TestModel1

-(void)getMyBlock:(void (^)(void))block{
    block();
}

-(void)testBlock:(TestBlock)block{
    self.block = block;
    self.block();
}

+(TestModel1 *)shareTestModelWithBlock:(TestBlock)block{
    TestModel1 * model1 = [[TestModel1 alloc] init];
    model1.block = block;
    model1.block();
    return model1;
}

@end
