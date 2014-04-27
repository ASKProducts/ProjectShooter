//
//  Definitions.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/21/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#ifndef ProjectShooter_Definitions_h
#define ProjectShooter_Definitions_h

typedef enum{
    PSPlayerTypeShooter = 1,
    PSPlayerTypeHelicopter
}PSPlayerType;

CGFloat CGPointDistance(CGPoint point1, CGPoint point2);
CGFloat CGVectorMagnitude(CGVector v);
CGFloat CGVectorAngle(CGVector v);

//Add pause/resume features for CALayers, code copied from Apple
@interface CALayer (playpause)
-(void)pauseLayer;
-(void)resumeLayer;
@end


//Interesting little warning suppressor (courtesy of stackoverflow)
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#define MY_SIZE CGSizeMake(480,320)

#define SCREEN_SIZE CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)

//Numbers can be scaled in two directions, width and height
#define CGFloatS_W(f) ((f)/MY_SIZE.width*SCREEN_SIZE.width)
#define CGFloatS_H(f) ((f)/MY_SIZE.height*SCREEN_SIZE.height)

//The following are functions that scale the coordinates from MY_SIZE to SCREEN_SIZE
CGPoint CGPointS(CGPoint p);
CGPoint CGPointS_W(CGPoint p);
CGPoint CGPointS_H(CGPoint p);

CGSize CGSizeS(CGSize s);
CGSize CGSizeS_W(CGSize s);
CGSize CGSizeS_H(CGSize s);

CGRect CGRectS(CGRect r);
CGRect CGRectS_W(CGRect r);
CGRect CGRectS_H(CGRect r);

#pragma mark - Misc

#define FRAMERATE (1.0f/30.0f)

//measured in pixels per second per second
#define GRAVITY CGFloatS_H(200.0)
#define GRAVITY_DEVIATION CGFloatS_H(40.0)

#pragma mark - UI

#define DIRECTION_BUTTON_SIZE_ CGSizeMake(75,75)
#define DIRECTION_BUTTON_SIZE  CGSizeS_H(DIRECTION_BUTTON_SIZE_)

#define LEFT_DIRECTION_TAG 101
#define RIGHT_DIRECTION_TAG 102

#define LEFT_DIRECTION_IMAGE @"left_arrow.png"
#define LEFT_DIRECTION_IMAGE_PRESSED @"left_arrow_pressed.png"
#define RIGHT_DIRECTION_IMAGE @"right_arrow.png"
#define RIGHT_DIRECTION_IMAGE_PRESSED @"right_arrow_pressed.png"


#define PLAYER_SWIPE_ZONE CGRectMake(DIRECTION_BUTTON_SIZE.width, SCREEN_SIZE.height-DIRECTION_BUTTON_SIZE.height, \
                                     SCREEN_SIZE.width-2*DIRECTION_BUTTON_SIZE.width, DIRECTION_BUTTON_SIZE.height)

#define PLAYER_SHOOTING_TAP_ZONE CGRectMake(0,0, SCREEN_SIZE.width, SCREEN_SIZE.height - DIRECTION_BUTTON_SIZE.height)

#define GROUND_SIZE_ 10
#define GROUND_SIZE  CGFloatS_H(GROUND_SIZE_)

#define MAXIMUM_TAP_DURATION 0.35

#pragma mark - Shooter

#define SHOOTER_IMAGE @"Tank.png"

#define SHOOTER_SIZE_ CGSizeMake(70,66)
#define SHOOTER_SIZE  CGSizeS_H(SHOOTER_SIZE_)

#define SHOOTER_STARTING_RELOAD_TIME 2

#define SHOOTER_SPEED CGFloatS_W(150)

#define SHOOTER_ROAMING_RANGE NSMakeRange(DIRECTION_BUTTON_SIZE.width + SHOOTER_SIZE.width/2, \
SCREEN_SIZE.width-(DIRECTION_BUTTON_SIZE.width + SHOOTER_SIZE.width/2)*2)


#pragma mark - Helicopter

#define HELICOPTER_IMAGE @"Helicopter-1.png"

#define HELICOPTER_SIZE_ CGSizeMake(125,50)
#define HELICOPTER_SIZE  CGSizeS_H(HELICOPTER_SIZE_)

#define HELICOPTER_ROAMING_REGION_ CGRectMake(DIRECTION_BUTTON_SIZE_.width+HELICOPTER_SIZE_.width/2, HELICOPTER_SIZE_.height/2, MY_SIZE.width-HELICOPTER_SIZE_.width-DIRECTION_BUTTON_SIZE_.width*2, 100-HELICOPTER_SIZE_.height)
#define HELICOPTER_ROAMING_REGION  CGRectS(HELICOPTER_ROAMING_REGION_)

#define HELICOPTER_STARTING_SPEED_ 30
#define HELICOPTER_STARTING_SPEED  CGFloatS_H(HELICOPTER_STARTING_SPEED_)

#define HELICOPTER_MAX_SPEED_ 200
#define HELICOPTER_MAX_SPEED  CGFloatS_H(HELICOPTER_MAX_SPEED_)

#define HELICOPTER_STARTING_DROP_FREQUENCY (3.0)

#define HELICOPTER_MAX_DROP_FREQUENCY (0.4)

//Amount of seconds it takes for PSHelicopter.speed to increase by 1
#define HELICOPTER_SKILL_INCREASE_TIME 6

#define HELICOPTER_SKILL_TO_SPEED_(skill) (skill*(3)+HELICOPTER_STARTING_SPEED_)
#define HELICOPTER_SKILL_TO_SPEED(skill)  CGFloatS_W(HELICOPTER_SKILL_TO_SPEED_(skill))

#define HELICOPTER_SKILL_TO_DROP_FREQUENCY(skill) (HELICOPTER_STARTING_DROP_FREQUENCY-skill*(0.05))

#pragma mark - Droppers

#define DROPPER_CLASSES         @[[PSBomb class], [PSBoulder class], [PSBonus class]]
#define DROPPER_PROBABILITIES   @[@3            , @1               , @0]
#define DROPPER_PROBABILITY_SUM 4


#pragma mark - Bombs

#define BOMB_IMAGE @"bomb.png"
#define BOMB_HELICOPTER_SKILL_TO_SIZE(x) //TODO: build BOMB_HELICOPTER_SKILL_TO_SIZE

#define BOMB_STARTING_SIZE CGSizeS_H(CGSizeMake(10,10))
#define BOMB_PHYSICAL_SIZE(x) CGSizeMake(BOMB_STARTING_SIZE.width * (powf(1.1,x)), BOMB_STARTING_SIZE.height * (powf(1.1,x)))


#pragma mark - Boulder

#define BOULDER_IMAGE @"boulder.png"

//TODO: build boulder size functions

#endif
