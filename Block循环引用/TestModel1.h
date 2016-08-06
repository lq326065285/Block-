//
//  TestModel1.h
//  Block循环引用
//
//  Created by ~~浅笑 on 16/8/4.
//  Copyright © 2016年 广东康爱多连锁药店有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TestBlock)();

@interface TestModel1 : NSObject

@property (nonatomic,strong) NSString * name;

@property (nonatomic,strong) NSMutableArray * arr;

@property (nonatomic,copy) id myBlock;

-(void)getMyBlock:(void (^)(void))block;


-(void)testBlock:(TestBlock)block;
@property (nonatomic,copy) TestBlock block;


+(TestModel1 *)shareTestModelWithBlock:(TestBlock)block;
@end
