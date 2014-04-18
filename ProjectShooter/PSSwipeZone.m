//
//  PSSwipeZone.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/17/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSSwipeZone.h"

@implementation PSSwipeZone{
    CGRect _touchBounds;
}

-(instancetype)initWithGameManager:(PSGameManager *)gameManager andReciever:(id<PSSwipeZoneReciever>)reciever andTouchBounds:(CGRect)touchBounds{
    self = [super initWithGameManager:gameManager];
    if (self) {
        self.reciever = reciever;
        self.acceptsTouches = YES;
        _touchBounds = touchBounds;
    }
    return self;
}

-(CGRect)touchBounds{
    return _touchBounds;
}

-(void)touchMoved:(PSTouch *)touch{
    if([self.reciever respondsToSelector:@selector(swipeRecieved:inSwipeZone:)])
        [self.reciever swipeRecieved:touch inSwipeZone:self];
}

@end
