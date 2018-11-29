//
//  NSMutableArray+Crash.m
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/21.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import "NSMutableArray+Crash.h"
#import "CrashMonitor.h"

@implementation NSMutableArray (Crash)
+(void)load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        Class class = NSClassFromString(@"__NSArrayM");
        
        [CrashMonitor swizzedClass:class Method:@selector(objectAtIndex:) withMethod:@selector(crash_objectAtIndex:)];
        [CrashMonitor swizzedClass:class Method:@selector(containsObject:) withMethod:@selector(crash_containsObject:)];
        [CrashMonitor swizzedClass:class Method:@selector(indexOfObject:) withMethod:@selector(crash_indexOfObject:)];
        [CrashMonitor swizzedClass:class Method:@selector(indexOfObject:inRange:) withMethod:@selector(crash_indexOfObject:inRange:)];
        
        [CrashMonitor swizzedClass:class Method:@selector(addObject:) withMethod:@selector(crash_addObject:)];
        [CrashMonitor swizzedClass:class Method:@selector(addObjectsFromArray:) withMethod:@selector(crash_addObjectsFromArray:)];
        [CrashMonitor swizzedClass:class Method:@selector(removeObject:) withMethod:@selector(crash_removeObject:)];
        
//        [CrashMonitor swizzedClass:class Method:@selector(insertObject:atIndex:) withMethod:@selector(crash_insertObject:atIndex:)];
        
    });
}

- (void)crash_addObject:(id)anObject {
    if(!anObject) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_addObject:anObject];
}

- (void)crash_addObjectsFromArray:(NSArray *)otherArray {
    if(!otherArray) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_addObjectsFromArray:otherArray];
}

- (void)crash_removeObject:(id)anObject {
    if(!anObject) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return;
    }
    [self crash_removeObject:anObject];
}

//- (void)crash_insertObject:(id)anObject atIndex:(NSUInteger)index {
//    if(!anObject || index >= [self count]) {
//        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
//        return;
//    }
//    return [self crash_insertObject:anObject atIndex:index];
//}
//



- (BOOL)crash_containsObject:(id)anObject {
    if(!anObject) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return NO;
    }
    return [self crash_containsObject:anObject];
    
}

- (id)crash_objectAtIndex:(NSUInteger)index {
    if(index >= [self count]) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return nil;
    }
    return [self crash_objectAtIndex:index];
}


- (NSUInteger)crash_indexOfObject:(id)anObject {
    if(!anObject) {
        NSLog(@"Crash by [%s %@]", object_getClassName(self) ,NSStringFromSelector(_cmd));
        return 0;
    }
    return [self crash_indexOfObject:anObject];
}

- (NSUInteger)crash_indexOfObject:(id)anObject inRange:(NSRange)range {
    if(!anObject || range.location + range.length >= self.count) {
        return 0;
    }
    return [self crash_indexOfObject:anObject inRange:range];
}
@end
