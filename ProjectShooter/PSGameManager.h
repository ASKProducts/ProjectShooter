//
//  PSGameManager.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definitions.h"
#import "PSButton.h"
#import "PSSwipeZone.h"

@class PSGameViewController, PSScreenElement, PSShooter, PSHelicopter, PSInteractive;

@interface PSGameManager : NSObject <PSButtonReciver, PSSwipeZoneReciever>

#pragma mark - initialization

//The main constructor
- (instancetype)initWithViewController:(PSGameViewController*)viewController
                         isMultiplayer:(BOOL)multiplayer;

//Called by the view controller at viewDidLoad
-(void)setUpScreen;

#pragma mark - Screen

//The view controller that handles what goes on the screen
@property PSGameViewController *viewController;

//An immutable copy of the elements that are on the screen
-(NSArray *)allScreenElements;

//ONLY add/remove screen elements to the screen by calling addScreenElement and removeScreenElement because they ensure that they are also added and removed from the corresponding view controller's view.
-(void)addScreenElement:(PSScreenElement*)element;
-(void)removeScreenElement:(PSScreenElement*)element;


#pragma mark - Game Type

//Is YES if the player is playing with another player
@property (readonly) BOOL isMultiplayer;


#pragma mark - Game Loop

//Straightforward boolean value
@property (readonly) BOOL isPaused;

//Simple functions that interact with the private NSTimer to pause and play the gameLoop
-(void)pause;
-(void)play;


#pragma mark - Input Handling

//A private set will be used to keep track of the touches. The view controller will send the touches to the game manager via registerTouch. registerTouch then packages those touches in PSTouches and sends them off to recieving screen elements
-(void)registerTouch:(UITouch*)touch;


#pragma mark - Game Elements

//The main character (shooter). Runs around on ground and shoots bombs + helicopter
@property (readonly) PSShooter *shooter;

//The AI antagonist. Flies in the sky and drops bombs + boulders
@property (readonly) PSHelicopter *helicopter;

//Array of all of the bombs currently on the screen
@property (readonly) NSMutableArray *bombs;

//Array of all of the boulders currently on the screen
@property (readonly) NSMutableArray *boulders;

@end
