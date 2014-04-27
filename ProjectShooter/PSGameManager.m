//
//  PSGameManager.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSGameManager.h"
#import "PSGameViewController.h"
#import "PSScreenElement.h"
#import "PSShooter.h"
#import "PSHelicopter.h"
#import "PSBomb.h"
#import "PSBoulder.h"
#import "PSTouch.h"
#import "PSTapZone.h"
#import "PSButton.h"
#import "PSSwipeZone.h"

#pragma mark - Ivars & Local Methods

@interface PSGameManager ()

//The following are redefitions of previous properties in order to allow readwrite access within the GameManager class
@property BOOL isMultiplayer;
@property BOOL isPaused;
@property PSShooter *shooter;
@property PSHelicopter *helicopter;
@property NSMutableArray *bombs;
@property NSMutableArray *boulders;

//The actual array holding all screen elements
@property NSMutableArray *screenElements;

//gameLooper calls the gameLoop method every FRAMERATE seconds and previousTime is used to calculate the delta time
@property NSTimer *gameLooper;
@property NSTimeInterval previousTime;
-(void)gameLoop;

//Array keeps track of all of the touches currently on the screen, stores them in the form of a stack
@property NSMutableArray *touches;

//A function that either creates a new PSTouch (for a new touch) or fetches a corresponding PSTouch in the touches array
-(PSTouch*)getPSTouchFromUITouch:(UITouch*)touch;

//These frames get resued, so lets keep them stored in a variable
@property CGRect leftButtonFrame;
@property CGRect rightButtonFrame;

//To measure the shooting, we'll use a tap zone element
@property PSTapZone *shootingTapZone;

//We measure the dragging back and forth (to aim the gun) with a swipe zone
@property PSSwipeZone *aimingSwipeZone;

//The direction buttons
@property PSButton *leftButton;
@property PSButton *rightButton;

@end



@implementation PSGameManager

#pragma mark - initialization

- (instancetype)initWithViewController:(PSGameViewController*)viewController
                         isMultiplayer:(BOOL)multiplayer{
    self = [super init];
    if (self) {
        _screenElements   = [[NSMutableArray alloc] initWithCapacity:100];
        _viewController   = viewController;
        _isMultiplayer    = multiplayer;
        _isPaused         = YES;
        _touches          = [[NSMutableArray alloc] initWithCapacity:10];
        _shooter          = [[PSShooter alloc] init];
        _helicopter       = [[PSHelicopter alloc] init];

        _leftButtonFrame  = CGRectMake(0, SCREEN_SIZE.height-DIRECTION_BUTTON_SIZE.height,
                                       DIRECTION_BUTTON_SIZE.width, DIRECTION_BUTTON_SIZE.height);

        _rightButtonFrame = CGRectMake(SCREEN_SIZE.width-DIRECTION_BUTTON_SIZE.width,
                                        SCREEN_SIZE.height-DIRECTION_BUTTON_SIZE.height,
                                        DIRECTION_BUTTON_SIZE.width,
                                        DIRECTION_BUTTON_SIZE.height);
    }
    return self;
}

-(void)setUpScreen{
    self.shooter = [[PSShooter alloc] initWithGameManager:self];
    [self addScreenElement:self.shooter];
    
    self.helicopter = [[PSHelicopter alloc] initWithGameManager:self];
    [self addScreenElement:self.helicopter];

    
    self.leftButton = [[PSButton alloc] initWithGameManager:self
                                                andReciever:self
                                                  andBounds:self.leftButtonFrame
                                             andNormalImage:[UIImage imageNamed:LEFT_DIRECTION_IMAGE]
                                            andPressedImage:[UIImage imageNamed:LEFT_DIRECTION_IMAGE_PRESSED]];
    [self addScreenElement:self.leftButton];
    
    
    self.rightButton = [[PSButton alloc] initWithGameManager:self
                                                 andReciever:self
                                                   andBounds:self.rightButtonFrame
                                              andNormalImage:[UIImage imageNamed:RIGHT_DIRECTION_IMAGE]
                                             andPressedImage:[UIImage imageNamed:RIGHT_DIRECTION_IMAGE_PRESSED]];
    [self addScreenElement:self.rightButton];
    
    
    self.shootingTapZone = [[PSTapZone alloc] initWithGameManager:self
                                                  andTouchBounds:PLAYER_SHOOTING_TAP_ZONE
                                                       andTarget:self.shooter
                                                     andSelector:@selector(fireBullet)];
    [self addScreenElement:self.shootingTapZone];

    
    self.aimingSwipeZone = [[PSSwipeZone alloc] initWithGameManager:self
                                                        andReciever:self
                                                     andTouchBounds:PLAYER_SWIPE_ZONE];
    [self addScreenElement:self.aimingSwipeZone];
    
    
    
    
}

#pragma mark - Screen Element Handling

-(NSArray*)allScreenElements{
    return [NSArray arrayWithArray:self.screenElements];
}

-(void)addScreenElement:(PSScreenElement*)element{
    [self.viewController.view addSubview:element.view];
    [self.screenElements addObject:element];
}

-(void)removeScreenElement:(PSScreenElement*)element{
    [element.view removeFromSuperview];
    [self.screenElements removeObject:element];
}


#pragma mark - Game Loop

-(void)pause{
    if(self.gameLooper)
        [self.gameLooper invalidate];
    self.gameLooper = nil;
    self.isPaused = YES;
    
    for (PSScreenElement *element in self.screenElements) {
        [element pause];
    }
}

-(void)play{
    self.gameLooper = [NSTimer scheduledTimerWithTimeInterval:FRAMERATE
                                                       target:self
                                                     selector:@selector(gameLoop)
                                                     userInfo:nil
                                                      repeats:YES];
    self.isPaused = NO;
    
    for (PSScreenElement *element in self.screenElements) {
        [element play];
    }
    
}

-(void)gameLoop{
    
    //calculate delta
    NSTimeInterval now   = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval delta = (self.previousTime) ? now - self.previousTime : FRAMERATE;
    
    //call update to all screenElements
    NSArray *elements = self.allScreenElements;
    for (PSScreenElement *element in elements) {
        [element updateWithDeltaTime:delta];
    }
    
    //the direction button functions. left is favored over right
    if(self.leftButton.isPressed)
        self.shooter.velocity = -SHOOTER_SPEED;
    else if(self.rightButton.isPressed)
        self.shooter.velocity = SHOOTER_SPEED;
    else
        self.shooter.velocity = 0;
    
    //TODO: add rest of gameLoop
}


#pragma mark - Touch Methods

-(PSTouch*)getPSTouchFromUITouch:(UITouch*)touch{
    
    PSTouch *pstouch;
    
    switch (touch.phase) {
        case UITouchPhaseBegan:
            pstouch = [[PSTouch alloc] initWithUITouch:touch andGameManager:self];
            [self.touches addObject:pstouch];
            break;
            
        case UITouchPhaseMoved:
        case UITouchPhaseStationary:
            pstouch = self.touches[[self.touches indexOfObject:touch]];
            break;
            
        case UITouchPhaseEnded:
        case UITouchPhaseCancelled:
            pstouch = self.touches[[self.touches indexOfObject:touch]];
            [self.touches removeObject:pstouch];
            break;
    }
    
    return pstouch;
}

-(void)registerTouch:(UITouch*)touch{
    
    PSTouch *pstouch = [self getPSTouchFromUITouch:touch];
    
    for (PSScreenElement *element in self.screenElements) {
        if(element.acceptsTouches){
            //If a touch started in your touchBounds then that is what we register to you
            if(CGRectContainsPoint(element.touchBounds, pstouch.originalLocation))
                [element registerTouch:pstouch];
        }
    }
}

-(void)swipeRecieved:(PSTouch*)swipe inSwipeZone:(PSSwipeZone*)zone{
    CGVector delta = CGVectorMake(swipe.localDelta.dx, SCREEN_SIZE.height/2);
    CGFloat deltaDirection = CGVectorAngle(delta) - M_PI_2;
    self.shooter.direction += deltaDirection;
}


@end
