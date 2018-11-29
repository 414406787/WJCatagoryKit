//
//  CrashMonitor.m
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/23.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import "CrashMonitor.h"
#import <objc/runtime.h>

@implementation CrashMonitor

+ (void)swizzedClass:(Class)class Method:(SEL)originalSelector withMethod:(SEL )swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
