//
//  PSTapZone.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/17/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSTapZone.h"
#import "PSTouch.h"
#import "Definitions.h"

@implementation PSTapZone{
    CGRect _touchBounds;
    __strong id _target;
    SEL _selector;
}

-(instancetype)initWithGameManager:(PSGameManager *)gameManager andTouchBounds:(CGRect)touchBounds andTarget:(id)target andSelector:(SEL)selector{
    self = [super initWithGameManager:gameManager];
    if (self) {
        _touchBounds = touchBounds;
        self.acceptsTouches = YES;
        _target = target;
        _selector = selector;
    }
    return self;
}

-(CGRect)touchBounds{
    return _touchBounds;
}

-(void)touchEnded:(PSTouch *)touch{
    NSTimeInterval current = [NSDate timeIntervalSinceReferenceDate];
    if(current - touch.originalTime <= MAXIMUM_TAP_DURATION){
        if([_target respondsToSelector:_selector])
            SuppressPerformSelectorLeakWarning([_target performSelector:_selector]);
    }
}

@end
