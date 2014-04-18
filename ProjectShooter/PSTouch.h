//
//  PSTouch.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/15/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PSGameManager;
//A class that is used to store the information in a touch
@interface PSTouch : NSObject

@property PSGameManager *manager;

@property UITouch *base;
@property (readonly) CGPoint originalLocation;
@property (readonly) NSTimeInterval originalTime;

-(CGPoint)location;
-(CGPoint)previousLocation;

-(CGVector)localDelta; //delta between previousLocation and location
-(CGVector)overallDelta; //delta between originalLocation and location

-(NSTimeInterval)localTimeDelta; //time difference of current time and base.timestamp
-(NSTimeInterval)overallTimeDelta; //time difference of current time and originalTime

-(instancetype)initWithUITouch:(UITouch*)base andGameManager:(PSGameManager*)manager;

@end
