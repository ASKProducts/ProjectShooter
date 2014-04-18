//
//  PSScreenElement.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@class PSGameManager, PSTouch;

//Abstract class for any element that is displayed on the screen
@interface PSScreenElement : NSObject

//A nice little property that can be used at will
@property NSInteger tag;

//The UIImageView counterpart that gets rendered
@property UIImageView *view;

//The Game Manager that is tied to this element
@property PSGameManager *gameManager;

//The default constructor
-(instancetype)initWithGameManager:(PSGameManager*)gameManager;

//This method is solely for overriding in subclasses
-(void)updateWithDeltaTime:(CGFloat)delta;

//When the GameManager is paused and played, it calls pause and play to all of its screenElements. The default implementation just simply pauses/resumes all animations taking place in the CALayer. Any subclass that overrides must call [super pause] or [super play]
-(void)pause;
-(void)play;


//Here is how touches work. If the screen element has acceptsTouches set to YES the the game manager will call -registerTouch:. -registerTouch: should NOT be overriden! -registerTouch: will make sure that the touches array is up to date and it will call the proper touch functions which are made to be overriden.

//Whether or not this element accepts touches
@property BOOL acceptsTouches;

//The bounds for touching. Overridable, the default is the bounds of the view counterpart.
-(CGRect)touchBounds;

//Solely an immutable copy of the touches array is given because -registerTouch: should handle the adding and deleting
-(NSArray*)touches;

//See above description
-(void)registerTouch:(PSTouch*)touch;

//The overridable touch functions
-(void)touchBegan:(PSTouch*)touch;
-(void)touchMoved:(PSTouch*)touch;
-(void)touchEnded:(PSTouch*)touch;

@end
