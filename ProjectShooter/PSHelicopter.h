//
//  PSHelicopter.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSPlayer.h"
#import <QuartzCore/QuartzCore.h>

//The class of the helicopter that roams the top of the screen and drops bombs
@interface PSHelicopter : PSPlayer 

//Almost all charictaristics (speed, drop frequency, etc) are funtions of the skill level and some random deviation
@property (readonly) NSInteger skillLevel;

//The (pixels per second) speed in which the helicopter roams
@property (readonly) CGFloat speed;

@property (readonly) CGFloat dropFrequency;

//The helicopter is constantly wandering from its current location to destination and when it reaches destination is resets destination
@property CGPoint destination;

//Starts the animation/motion process
-(void)startMotion;


@end
