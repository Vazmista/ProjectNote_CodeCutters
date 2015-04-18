//
//  Calculator.h
//  PracticeExercises
//
//  Created by Val on 18/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

+ (float)addValue:(float)firstValue to:(float)secondValue;
+ (float)subtractValue:(float)firstValue from:(float)secondValue;
+ (float)sum:(NSArray *)numbersToBeAdded;

# warning TODO 2: Write a multiplication Class Method

@end
