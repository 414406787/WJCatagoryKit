//
//  NSMutableString+Crash.m
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/23.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import "NSMutableString+Crash.h"
#import "CrashMonitor.h"

@implementation NSMutableString (Crash)
+(void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class class = NSClassFromString(@"__NSCFString");
        
        [CrashMonitor swizzedClass:class Method:@selector(replaceCharactersInRange:withString:) withMethod:@selector(crash_replaceCharactersInRange:withString:)];
        [CrashMonitor swizzedClass:class Method:@selector(insertString:atIndex:) withMethod:@selector(crash_insertString:atIndex:)];
        [CrashMonitor swizzedClass:class Method:@selector(deleteCharactersInRange:) withMethod:@selector(crash_deleteCharactersInRange:)];
        [CrashMonitor swizzedClass:class Method:@selector(setString:) withMethod:@selector(crash_setString:)];
        [CrashMonitor swizzedClass:class Method:@selector(appendString:) withMethod:@selector(crash_appendString:)];
        
    });
}

- (void)crash_replaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if(!aString || [aString length] <= 0 || [self length] <= range.location + range.length) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_replaceCharactersInRange:range withString:aString];
}

- (void)crash_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if(!aString || [aString length] <= 0 || [self length] <= loc) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_insertString:aString atIndex:loc];
}

- (void)crash_deleteCharactersInRange:(NSRange)range {
    if([self length] <= range.location + range.length) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_deleteCharactersInRange:range];
}

- (void)crash_setString:(NSString *)aString {
    if(!aString || aString.length <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_setString:aString];
}

- (void)crash_appendString:(NSString *)aString {
    if(!aString || aString.length <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_appendString:aString];
}
@end
