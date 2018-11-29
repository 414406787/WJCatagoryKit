//
//  CrashMonitor.h
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/23.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CrashMonitor : NSObject
+ (void)swizzedClass:(Class)class Method:(SEL)originalSelector withMethod:(SEL )swizzledSelector;
@end

NS_ASSUME_NONNULL_END
