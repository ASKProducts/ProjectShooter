//
//  PSShooter.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSShooter.h"
#import "Definitions.h"

@interface PSShooter ()

@property CGFloat timeSinceLastReload;

@end

@implementation PSShooter

@synthesize direction = _direction;

-(instancetype)initWithGameManager:(PSGameManager *)gameManager{
    self = [super initWithGameManager:gameManager];
    if (self) {
        self.view                = [[UIImageView alloc] initWithImage:[UIImage imageNamed:SHOOTER_IMAGE]];
        self.view.bounds         = CGRectMake(0, 0, SHOOTER_SIZE.width, SHOOTER_SIZE.height);
        self.view.center         = CGPointMake(SCREEN_SIZE.width/2,
                                       SCREEN_SIZE.height - (GROUND_SIZE + SHOOTER_SIZE.height/2));

        self.health              = 1;
        self.velocity            = 0;
        self.direction           = M_PI_2; //Gun always starts facing straight up
        self.reloadTime          = SHOOTER_STARTING_RELOAD_TIME;
        self.timeSinceLastReload = 0;
        self.readyToFire         = YES;
    }
    return self;
}

-(void)updateWithDeltaTime:(CGFloat)delta{
    CGFloat newX = self.view.center.x + self.velocity * delta;
    
    if(NSLocationInRange(newX, SHOOTER_ROAMING_RANGE)){
        self.view.center = CGPointMake(newX, self.view.center.y);
    }
    
    if(!self.readyToFire){
        self.timeSinceLastReload += delta;
        if(self.timeSinceLastReload >= self.reloadTime){
            self.timeSinceLastReload = 0;
            self.readyToFire = YES;
            NSLog(@"Ready To Fire");
        }
    }
}


-(CGFloat)direction{
    return _direction;
}
-(void)setDirection:(CGFloat)direction{
    
    //bound the direction to the interval of [0,pi]
    if(direction < 0)
        _direction = 0;
    else if (direction > M_PI)
        _direction = M_PI;
    else
        _direction = direction;
    
    //TODO: change gun direction accordingly (implement multi-image flow)
    self.view.layer.affineTransform = CGAffineTransformMakeRotation(M_PI_2 - _direction);
}

-(void)fireBullet{
    if(!self.readyToFire)return;
    NSLog(@"Fire!");
    self.readyToFire = NO;
    
    //TODO: program bullet firing
}

@end
