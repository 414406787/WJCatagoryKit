//
//  NSDictionary+Crash.m
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/23.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import "NSDictionary+Crash.h"
#import "CrashMonitor.h"

@implementation NSDictionary (Crash)
+(void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        
        Class class = NSClassFromString(@"__NSSingleEntryDictionaryI");
        
        [CrashMonitor swizzedClass:class Method:@selector(initWithDictionary:) withMethod:@selector(crash_initWithDictionary:)];
        [CrashMonitor swizzedClass:class Method:@selector(objectForKey:) withMethod:@selector(crash_objectForKey:)];
    });
}

- (instancetype)crash_initWithDictionary:(NSDictionary *)otherDictionary {
    if(!otherDictionary) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return [NSDictionary dictionary];
    }
    return [self crash_initWithDictionary:otherDictionary];
}

- (id)crash_objectForKey:(id)aKey {
    if(!aKey || [aKey length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return nil;
    }
    return [self crash_objectForKey:aKey];
}

@end
