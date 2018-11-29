//
//  NSMutableDictionary+Crash.m
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/26.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import "NSMutableDictionary+Crash.h"
#import "CrashMonitor.h"

@implementation NSMutableDictionary (Crash)
+(void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class class = NSClassFromString(@"__NSDictionaryM");
        [CrashMonitor swizzedClass:class Method:@selector(setObject:forKey:) withMethod:@selector(crash_setObject:forKey:)];
        [CrashMonitor swizzedClass:class Method:@selector(removeObjectForKey:) withMethod:@selector(crash_removeObjectForKey:)];
    });
}

- (void)crash_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if(!anObject || !aKey) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_setObject:anObject forKey:aKey];
}

- (void)crash_removeObjectForKey:(id)aKey {
    if(!aKey) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_removeObjectForKey:aKey];
}

@end
