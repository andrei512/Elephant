//
//  NSObject+Elephant.h
//  Gifts
//
//  Created by Andrei on 9/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^DataLambda)(void);

NSString *callerKey(void);
id remember(DataLambda dataLambda);

@interface NSObject (Elephant)

+ (NSMutableDictionary *)brain;

- (id)remember:(DataLambda)dataLambda;
+ (id)remember:(DataLambda)dataLambda;
+ (id)remember:(DataLambda)dataLambda forKey:(NSString *)key;

@end
