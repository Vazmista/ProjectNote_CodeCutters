//
//  ViewController.m
//  PracticeExercises
//
//  Created by Val on 18/04/2015.
//  Copyright (c) 2015 CodeCutters. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self runCalculatorTestScript];
}

- (void)runCalculatorTestScript
{
    // Calculator test Scripts
    float total = 0.0;
    total = [Calculator addValue:12.1 to:15.2];
    NSLog(@"Adding 12.1 & 15.2:%f", total); // Prints this to console
    
    total = [Calculator subtractValue:6.2 from:21.5];
    NSLog(@"Subtracting 6.2 from 21.5:%f", total); // Prints this to console
    
    total = [Calculator sum:@[@54.1,@512.2,@685,@19.9]];
    NSLog(@"Sums the vales together:%f", total); // Prints to console
    
#warning TODO 1: Write some of your own examples. Make sure you print to screen to make sure they work
    
    
    
#warning TODO 4: Write some examples of Multiply working
    
}

- (void)runAnimalTestScript
{
#warning TODO 5: #import animal and write some example animales (call the Move() method to see the outcome) *** Don't forget to run this method runAnimalTestScript in the viewDidLoad method
    
    
#warning TODO 6: #import Landcreature and write some example creatures (call the Move() and Jump() methods to see what happens)
    
    
#warning TODO 7: #import Bird and write some example birds (call the Move() and Fly() methods to see what gets printed)
    
}

- (void)runVehicleTestScript
{

#warning TODO 8: Create your own Vehicle class which has a property of numberOfWheels and a method of Move() *** Don't forget to run this method (runVehicleTestScript) in the viewDidLoad method
    
#warning TODO 9: Create a MotorBike class which extends Vehicle, property of maxSpeed & acceleration, a method of Grunt() and overwite Move(). Also, customise the init to have the default of wheels to 2 and max speed to 100.. (see Bird.m for example)
    
#warning TODO 10: Create a Car class which extends Vehicle, property of maxNumberOfPassangers & currentNumberOfPassangers, with a method of HowManyMorePassangersCanCarHold() - This method should return the number of spaces left in the vehicle. Customise the init to set a default of 4 wheels and 5 passangers.
    
#warning TODO 11: Create a Limo class which extends Car; add a property of isHummerLimo and create a method GoToParty(). Customise the init to set isHummerLimo as a default to NO, wheels to 6.
    
#warning TODO 12: Import all previously created classes to this class and start creating Vehicles, MotorBikes, Cars and Limo's... Try different things, see how things interact. Don't forget to print to console (NSLog) to see what output you get.
    
#warning TODO 13: Think of some class methods for Limo and MotorBike which you could implement, and call them.
    
}

@end
