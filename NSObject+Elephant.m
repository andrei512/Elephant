//
//  NSObject+Elephant.m
//  Gifts
//
//  Created by Andrei on 9/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSObject+Elephant.h"

NSString *callerKey(void) {
    NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:2];
    // Example: 1   UIKit                               0x00540c89 -[UIApplication _callInitializationDelegatesForURL:payload:suspended:] + 1163
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" []?.,"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    [array removeObject:@""];
    
//    NSLog(@"Stack = %@", [array objectAtIndex:0]);
//    NSLog(@"Framework = %@", [array objectAtIndex:1]);
//    NSLog(@"Memory address = %@", [array objectAtIndex:2]);
//    NSLog(@"type of caller = %@", [array objectAtIndex:3]);
//    NSLog(@"Class caller = %@", [array objectAtIndex:4]);
//    NSLog(@"Function caller = %@", [array objectAtIndex:5]);
//    NSLog(@"Line caller = %@", [array objectAtIndex:7]);
    
    NSString *key = [NSString stringWithFormat:@"%@[%@ %@]:%@", 
                     [array objectAtIndex:3],
                     [array objectAtIndex:4],
                     [array objectAtIndex:5],
                     [array objectAtIndex:7]
                     ];
    return key;
}

id remember(DataLambda dataLambda) {
    return [NSObject remember:dataLambda forKey:callerKey()];
}

@implementation NSObject (Elephant)

+ (NSMutableDictionary *)brain {
    static NSMutableDictionary *brainCollection = nil;
    unless (brainCollection) {
        brainCollection = [[NSMutableDictionary dictionary] retain];
    }
    NSString *brainKey = NSStringFromClass([self class]);
    NSMutableDictionary *brain = [brainCollection objectForKey:brainKey];
    unless (brain) {
        brain = [NSMutableDictionary dictionary];
        [brainCollection setObject:brain forKey:brainKey];
    }
    return brain;
}

+ (id)remember:(DataLambda)dataLambda forKey:(NSString *)key {
    NSMutableDictionary *brain = [self brain];    
    id value = [brain objectForKey:key];
    
    unless (value) {
        value = dataLambda();
        [brain setObject:value forKey:key];
    }
    
    return value;
}

- (id)remember:(DataLambda)dataLambda {
    NSString *key = [NSString stringWithFormat:@"%@|%d", callerKey(), self];
    return [[self class] remember:dataLambda forKey:key];
}

+ (id)remember:(DataLambda)dataLambda {
    NSString *key = callerKey();
    return [self remember:dataLambda forKey:key];
}


@end
