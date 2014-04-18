//
//  PSTouch.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/15/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSTouch.h"
#import "PSGameManager.h"
#import "PSGameViewController.h"

@implementation PSTouch

-(CGPoint)location{
    return [self.base locationInView:self.manager.viewController.view];
}

-(CGPoint)previousLocation{
    return [self.base previousLocationInView:self.manager.viewController.view];
}

-(instancetype)initWithUITouch:(UITouch*)base andGameManager:(PSGameManager*)manager{
    self = [super init];
    if (self) {
        _base = base;
        _manager = manager;
        _originalLocation = [base locationInView:_manager.viewController.view];
        _originalTime = [NSDate timeIntervalSinceReferenceDate];
    }
    return self;
}

//A [-PSTouch isEqual:-PSTouch.base] = YES
-(BOOL)isEqual:(id)object{
    if([object isKindOfClass:[UITouch class]]){
        return object == self.base;
    }
    return [super isEqual:object];
}

-(CGVector)localDelta{
    return CGVectorMake(self.location.x - self.previousLocation.x, self.location.y - self.previousLocation.y);
}

-(CGVector)overallDelta{
    return CGVectorMake(self.location.y - self.originalLocation.y, self.location.y - self.originalLocation.y);
}

-(NSTimeInterval)localTimeDelta{
    return [NSDate timeIntervalSinceReferenceDate] - self.base.timestamp;
}
-(NSTimeInterval)overallTimeDelta{
    return [NSDate timeIntervalSinceReferenceDate] - self.originalTime;
}

@end

@implementation UITouch (PSTouchEquality)

-(BOOL)isEqual:(id)object{
    if([object isKindOfClass:[PSTouch class]]){
        return self == [object base];
    }
    return [super isEqual:object];
}

@end
