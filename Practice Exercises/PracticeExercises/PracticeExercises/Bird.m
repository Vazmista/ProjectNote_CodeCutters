//
//  Bird.m
//  PracticeExercises
//
//  Created by Val on 18/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "Bird.h"

@implementation Bird

- (id)init // Here we are overloading the method init, to put some default values in
{
    self = [super init];
    if (self)
    {
        self.name = @"Bird with No name"; // This defaults name, you will need to overwrite name after initialising
        self.canFly = YES; // This mean all birds by default can fly, you will need to overwrite this after initialising to make it something different
    }
    
    return self;
}

- (void)fly
{
    // Original way of getting two different string depending on a bool
    NSString *canFlyString1 = nil;
    if (self.canFly)
    {
        canFlyString1 = @"can fly";
    }
    else
    {
        canFlyString1 = @"cannot fly";
    }
    NSLog(@"This Bird %@", canFlyString1);
    
    // Quick way of getting the can fly string
    NSString *canFlyString2 = self.canFly ? @"can fly" : @"cannot fly";
    
    NSLog(@"This Bird %@", canFlyString2);
    
    // Even quicker
    NSLog(@"This Bird %@", self.canFly? @"can fly" : @"cannot fly");
}

- (void)move
{
    NSLog(@"I, a Bird move quite weird");
}

@end
