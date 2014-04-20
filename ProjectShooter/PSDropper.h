//
//  PSDropper.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PSScreenElement.h"

//Abstract class to represent anything that falls from the sky
@interface PSDropper : PSScreenElement

//Speed in which the object falls (pixels per second)
@property CGFloat speed;

//A dropper who has active=NO is stationary (ex. a bonus laying on the ground)
@property BOOL isActive;

@end
