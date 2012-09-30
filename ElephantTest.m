//
//  ElephantTest.m
//  Gifts
//
//  Created by Andrei on 10/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ElephantTest.h"
#import "NSObject+Elephant.h"
#import "DebugHelpers.h"

@implementation ElephantTest

+ (void)test {
    for (int i = 0; i < 3; ++i) {
        id valueA = remember(^{
            NSLog(@"computing value A");
            NSString *result = @"";
            for (int j = 1; j < 60; ++j) {
                result = [result stringByAppendingString:@"A"];
            }
            return result;
        });
        PO(valueA)
        id valueB = remember(^{
            NSLog(@"computing value B");
            NSString *result = @"";
            for (int j = 1; j < 60; ++j) {
                result = [result stringByAppendingString:@"B"];
            }
            return result;
        });
        PO(valueB);
    }
}

@end
