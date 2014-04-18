//
//  PSShooter.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSPlayer.h"

//The class of the man with a gun raoming the bottom of the screen
@interface PSShooter : PSPlayer

//The "money" that the player has. Money is used to drop bombs and shoot etc.
@property CGFloat money;

//The "health" that the player has. It is expressed in the range [0,1].
@property CGFloat health;

//The 'x' velocity that the player is traveling
@property CGFloat velocity;

//The direction that the tank gun is facing (measured in radians w/ range of [0,pi]).
@property CGFloat direction;

//You can probably guess what this function does
-(void)fireBullet;

//Time it takes for the tank to reload (in seconds)
@property CGFloat reloadTime;

//The shooter is not ready to fire when the tank is reloading
@property BOOL readyToFire;

@end
