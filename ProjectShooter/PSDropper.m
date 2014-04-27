//
//  PSDropper.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSDropper.h"
#import "Definitions.h"
#import "PSBomb.h"
#import "PSBoulder.h"
#import "PSBonus.h"
#import "PSGameManager.h"
#import "PSHelicopter.h"

@interface PSDropper ()

@property CGFloat gravity;

@end

@implementation PSDropper

-(instancetype)initWithOwner:(PSHelicopter*)owner{
    self = [super initWithGameManager:owner.gameManager];
    if (self) {
        self.owner   = owner;
        self.speed   = 0;
        self.gravity = GRAVITY + (arc4random()%((int)GRAVITY_DEVIATION*2))-GRAVITY_DEVIATION;
    }
    return self;
}

-(void)updateWithDeltaTime:(CGFloat)delta{
    if(self.isActive){
        self.speed += delta*GRAVITY;
        
        self.view.layer.position = CGPointMake(self.view.center.x,
                                               self.view.center.y + self.speed*delta);
        //TODO: check for hitting the ground
    }
}

+(PSDropper*)generateRandomDropperWithOwner:(PSHelicopter*)owner{
    NSArray *classes = DROPPER_CLASSES;
    NSArray *probabilities = DROPPER_PROBABILITIES;
    
    //This is an interesting algorithm I learned online when studying genetic algorithms. Simply repeatedly pick a random element i and accept it with the acceptance probability of probability_i/probability_sum. This makes it so that each element will be accepted their probability of the time and tends to work much faster than linear time algorithms and much less complicated than binary search algorithms.

    PSDropper *dropper;
    while (true) {
        int i = arc4random()%classes.count;
        if(arc4random()%DROPPER_PROBABILITY_SUM <= [probabilities[i] intValue] && [probabilities[i] intValue] != 0){
            dropper = [[classes[i] alloc] initWithOwner:owner];
            break;
        }
    }
    return dropper;
}

@end
