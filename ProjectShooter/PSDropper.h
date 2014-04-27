//
//  PSDropper.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PSScreenElement.h"

@class PSHelicopter;

//Abstract class to represent anything that falls from the sky
@interface PSDropper : PSScreenElement

//Speed in which the object falls (pixels per second)
@property CGFloat speed;

//A dropper who has active=NO is stationary (ex. a bonus laying on the ground)
@property BOOL isActive;

//The helicopter that dropped this dropper
@property PSHelicopter *owner;

//The default constructor. Also, the ONLY constructor to be used because it must be used by all subclasses. It gets its gameManager from its owner
-(instancetype)initWithOwner:(PSHelicopter*)owner;

//A function to create an instance of a random subclass (see Definitions.h for this list of classes and probabilities)
+(PSDropper*)generateRandomDropperWithOwner:(PSHelicopter*)owner;

@end
