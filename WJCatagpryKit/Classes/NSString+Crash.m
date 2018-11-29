//
//  NSString+Crash.m
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/21.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import "NSString+Crash.h"
#import "CrashMonitor.h"
@implementation NSString (Crash)
+(void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class class = NSClassFromString(@"__NSCFConstantString");
        
        [CrashMonitor swizzedClass:class Method:@selector(characterAtIndex:) withMethod:@selector(crash_characterAtIndex:)];
        [CrashMonitor swizzedClass:class Method:@selector(substringFromIndex:) withMethod:@selector(crash_substringFromIndex:)];
        [CrashMonitor swizzedClass:class Method:@selector(substringToIndex:) withMethod:@selector(crash_substringToIndex:)];
        [CrashMonitor swizzedClass:class Method:@selector(substringWithRange:) withMethod:@selector(crash_substringWithRange:)];
        [CrashMonitor swizzedClass:class Method:@selector(hasPrefix:) withMethod:@selector(crash_hasPrefix:)];
        [CrashMonitor swizzedClass:class Method:@selector(hasSuffix:) withMethod:@selector(crash_hasSuffix:)];
        [CrashMonitor swizzedClass:class Method:@selector(containsString:) withMethod:@selector(crash_containsString:)];
        [CrashMonitor swizzedClass:class Method:@selector(rangeOfString:) withMethod:@selector(crash_rangeOfString:)];
        [CrashMonitor swizzedClass:class Method:@selector(stringByAppendingString:) withMethod:@selector(crash_stringByAppendingString:)];
        [CrashMonitor swizzedClass:class Method:@selector(componentsSeparatedByString:) withMethod:@selector(crash_componentsSeparatedByString:)];
    });
}

- (unichar)crash_characterAtIndex:(NSUInteger)index {
    if([self length] <= index) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return 0;
    }
    return [self crash_characterAtIndex:index];
}

- (NSString *)crash_substringFromIndex:(NSUInteger)from {
    
    if([self length] <= from) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return @"";
    }
    return [self crash_substringFromIndex:from];
}

- (NSString *)crash_substringToIndex:(NSUInteger)to {
    if([self length] <= to) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return @"";
    }
    return [self crash_substringToIndex:to];
}

- (NSString *)crash_substringWithRange:(NSRange)range {
    if([self length] <= range.location + range.length) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return @"";
    }
    return [self crash_substringWithRange:range];
}

- (BOOL)crash_hasPrefix:(NSString *)str {
    if (!str || [str length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return NO;
    }
    return [self crash_hasPrefix:str];
}
- (BOOL)crash_hasSuffix:(NSString *)str {
    if (!str || [str length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return NO;
    }
    return [self crash_hasSuffix:str];
}

- (BOOL)crash_containsString:(NSString *)str  {
    if (!str || [str length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return NO;
    }
    return [self crash_containsString:str];
}

- (NSRange)crash_rangeOfString:(NSString *)searchString {
    if (!searchString || [searchString length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return NSMakeRange(0, 0);
    }
    return [self crash_rangeOfString:searchString];
}

- (NSString *)crash_stringByAppendingString:(NSString *)aString {
    if (!aString || [aString length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return @"";
    }
    return [self crash_stringByAppendingString:aString];
}
//- (NSString *)crash_stringByAppendingFormat:(NSString *)format {
//    if (!format || [format length] <= 0) {
//        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
//        return @"";
//    }
//    return [self crash_stringByAppendingFormat:format];
//}

- (NSArray<NSString *> *)crash_componentsSeparatedByString:(NSString *)separator {
    if (!separator || [separator length] <= 0) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return nil;
    }
    return [self crash_componentsSeparatedByString:separator];
}
@end
