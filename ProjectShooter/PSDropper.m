//
//  PSDropper.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSDropper.h"

@interface PSDropper ()

@end

@implementation PSDropper

-(void)updateWithDeltaTime:(CGFloat)delta{
    if(self.isActive){
        self.view.layer.position = CGPointMake(self.view.center.x,
                                               self.view.center.y + self.speed*delta);
    }
}

@end
