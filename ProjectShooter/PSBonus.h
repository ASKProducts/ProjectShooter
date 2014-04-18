//
//  PSBonus.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSDropper.h"

typedef enum{
    PSBonusType_
}PSBonusType;

//A class to represent the bonuses that fall from the sky
@interface PSBonus : PSDropper

//The type of bonus is just its ability (aka what purpose it serves to the player)
@property PSBonusType bonusType;

@end
