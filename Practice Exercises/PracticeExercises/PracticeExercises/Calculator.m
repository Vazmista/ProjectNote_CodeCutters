//
//  Calculator.m
//  PracticeExercises
//
//  Created by Val on 18/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

+ (float)addValue:(float)firstValue to:(float)secondValue
{
    return firstValue+secondValue;
}

+ (float)subtractValue:(float)firstValue from:(float)secondValue
{
    return secondValue-firstValue;
}

+(float)sum:(NSArray *)numbersToBeAdded
{
    float total = 0.0;
    for (NSNumber *value in numbersToBeAdded)
    {
        if ([value isKindOfClass:[NSNumber class]]) // Make sure the object is of type NSNumber
        {
            total += [value floatValue];
        }
    }
    
    return total;
}

#warning TODO 3: Implement the multiplication class Method

@end
