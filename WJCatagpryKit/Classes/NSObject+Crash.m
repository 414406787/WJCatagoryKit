//
//  NSObject+Crash.m
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/23.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import "NSObject+Crash.h"
#import "CrashMonitor.h"

@implementation NSObject (Crash)
+(void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        [CrashMonitor swizzedClass:[self class] Method:@selector(setValue:forKey:) withMethod:@selector(crash_setValue:forKey:)];
    });
}

- (void)crash_setValue:(id)value forKey:(NSString *)key {
    if(!value || !key || [key length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_setValue:value forKey:key];
}
@end
