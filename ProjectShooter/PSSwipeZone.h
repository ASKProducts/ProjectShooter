//
//  PSSwipeZone.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/17/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSScreenElement.h"

@class PSSwipeZone;
@protocol PSSwipeZoneReciever <NSObject>

@optional
-(void)swipeRecieved:(PSTouch*)swipe inSwipeZone:(PSSwipeZone*)zone;

@end

//A class that works just like a PSTapZone except is handles swipes. Also static (touchBounds cannot be changed).
@interface PSSwipeZone : PSScreenElement

@property id<PSSwipeZoneReciever> reciever;

-(instancetype)initWithGameManager:(PSGameManager *)gameManager andReciever:(id<PSSwipeZoneReciever>)reciever andTouchBounds:(CGRect)touchBounds;

@end
