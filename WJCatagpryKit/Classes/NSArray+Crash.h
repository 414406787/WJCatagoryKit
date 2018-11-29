//
//  NSArray+Crash.h
//  TestDemo
//
//  Created by Wu,Jie(EBDPRD) on 2018/11/21.
//  Copyright © 2018年 Wu,Jie(EBDPRD). All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray <__covariant ObjectType>(Crash)
- (id)crash_objectAtIndex:(NSUInteger)index;
@end

NS_ASSUME_NONNULL_END
