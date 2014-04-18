//
//  PSScreenElement.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSScreenElement.h"
#import "Definitions.h"
#import "PSTouch.h"

@interface PSScreenElement ()


@end

@implementation PSScreenElement{
    NSMutableArray *_touches;
    BOOL isPaused;
}

-(instancetype)initWithGameManager:(PSGameManager*)gameManager{
    self = [super init];
    if (self) {
        _gameManager = gameManager;
        _touches = [NSMutableArray array];
    }
    return self;
}

-(void)updateWithDeltaTime:(CGFloat)delta{ }

-(void)pause{
    if(self.view.layer.animationKeys.count)
        [self.view.layer pauseLayer];
}

-(void)play{
    if(self.view.layer.animationKeys.count)
        [self.view.layer resumeLayer];
}

-(CGRect)touchBounds{
    if(self.view)
        return self.view.frame;
    
    return CGRectZero;
}

-(NSArray*)touches{
    return [NSArray arrayWithArray:_touches];
}

-(void)registerTouch:(PSTouch*)touch{
    if(touch.base.phase == UITouchPhaseBegan){
        [_touches addObject:touch];
        [self touchBegan:touch];
    }
    
    if(touch.base.phase == UITouchPhaseMoved){
        [self touchMoved:touch];
    }
    
    if (touch.base.phase == UITouchPhaseEnded){
        [_touches removeObject:touch];
        [self touchEnded:touch];
    }
}

-(void)touchBegan:(PSTouch*)touch {}
-(void)touchMoved:(PSTouch*)touch {}
-(void)touchEnded:(PSTouch*)touch {}

@end
