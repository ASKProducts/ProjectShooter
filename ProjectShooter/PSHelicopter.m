//
//  PSHelicopter.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSHelicopter.h"
#import "Definitions.h"
#import <QuartzCore/QuartzCore.h>

@interface PSHelicopter ()

//Redifitions for readwrite access
@property NSInteger skillLevel;
@property CGFloat speed;
@property CGFloat dropFrequency;

//Simple function thatgenerates a random point in the roaming region
-(CGPoint)generateNewDestination;

//The animation used for traveling around the screen
@property CABasicAnimation *motionAnimation;

@end

@implementation PSHelicopter{
    BOOL isLeft;
    CGFloat skillLevelTimeCounter;
    CGFloat dropFrequencyTimeCounter;
}

-(instancetype)initWithGameManager:(PSGameManager *)gameManager{
    self = [super initWithGameManager:gameManager];
    if (self) {
        //view initialization
        self.view        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:HELICOPTER_IMAGE]];
        self.view.bounds = CGRectMake(0, 0, HELICOPTER_SIZE.width, HELICOPTER_SIZE.height);
        self.view.center = CGPointMake(CGRectGetMidX(HELICOPTER_ROAMING_REGION),
                                       CGRectGetMidY(HELICOPTER_ROAMING_REGION));
        
        //roaming initialization
        self.speed       = HELICOPTER_STARTING_SPEED;
        self.dropFrequency = HELICOPTER_STARTING_DROP_FREQUENCY;
        self.destination = self.view.center;
        isLeft           = NO;
        skillLevelTimeCounter    = 0;
        dropFrequencyTimeCounter = 0;
    }
    return self;
}

#pragma mark - motion handling

-(void)startMotion{
    
    self.destination = [self generateNewDestination];
    
    CGPoint currentPosition = self.view.layer.position;
    
    self.motionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    
    self.motionAnimation.fromValue = [NSValue valueWithCGPoint:currentPosition];
    self.motionAnimation.toValue   = [NSValue valueWithCGPoint:self.destination];
    self.view.layer.position       = self.destination;
    
    if(( isLeft && self.destination.x > currentPosition.x) ||
       (!isLeft && self.destination.x < currentPosition.x)){
        [self flipImage];
        isLeft = !isLeft;
    }
    
    //d=rt, t=d/r
    self.motionAnimation.duration       = CGPointDistance(currentPosition, self.destination) / self.speed;
    self.motionAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    
    self.motionAnimation.delegate = self;
    [self.view.layer addAnimation:self.motionAnimation forKey:@"motionAnimation"];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.view.layer removeAnimationForKey:@"motionAnimation"];
    [self startMotion];
}

#pragma mark - gameloop

-(void)updateWithDeltaTime:(CGFloat)deltaTime{
    
    skillLevelTimeCounter += deltaTime;
    if(skillLevelTimeCounter > HELICOPTER_SKILL_INCREASE_TIME){
        self.skillLevel++;
        skillLevelTimeCounter = 0;
        
        self.speed = MIN(HELICOPTER_SKILL_TO_SPEED(self.skillLevel), HELICOPTER_MAX_SPEED);
        
        self.dropFrequency = MAX(HELICOPTER_SKILL_TO_DROP_FREQUENCY(self.skillLevel), HELICOPTER_MAX_DROP_FREQUENCY);
        //TODO: deal with changing of speed and other variables
        
    }
    
    dropFrequencyTimeCounter += deltaTime;
    if(dropFrequencyTimeCounter > self.dropFrequency){
        dropFrequencyTimeCounter = 0;
        //TODO: implement dropping
        NSLog(@"Drop! Skill:%d Frequency:%f",self.skillLevel,self.dropFrequency);
    }
}

-(CGPoint)generateNewDestination{
    int newX = arc4random() % (int)HELICOPTER_ROAMING_REGION.size.width;
    int newY = arc4random() % (int)HELICOPTER_ROAMING_REGION.size.height;
    
    return CGPointMake(newX + HELICOPTER_ROAMING_REGION.origin.x,
                       newY + HELICOPTER_ROAMING_REGION.origin.y);
}

@end
