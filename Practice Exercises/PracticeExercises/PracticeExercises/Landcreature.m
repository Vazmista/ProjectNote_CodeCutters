//
//  Landcreature.m
//  PracticeExercises
//
//  Created by Val on 18/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "Landcreature.h"

@implementation Landcreature

- (void)jump
{
    NSLog(@"This land creature:%@ just jumped with all %d legs", self.name, self.numberOfLegs);
}

- (void)move
{
    NSLog(@"I, as a Land Creature am moving using all %d legs", self.numberOfLegs);
}

@end
