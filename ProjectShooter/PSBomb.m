//
//  PSBomb.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSBomb.h"
#import "Definitions.h"
#import "PSHelicopter.h"

@implementation PSBomb

-(instancetype)initWithOwner:(PSHelicopter *)owner{
    self = [super initWithOwner:owner];
    if (self) {
        self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BOMB_IMAGE]];
        
        //TODO: add system where, as skill gets higher, bigger bombs become more likely
        self.size = owner.skillLevel;
        CGSize physicalSize = BOMB_PHYSICAL_SIZE(15);
        self.view.bounds = CGRectMake(0, 0, physicalSize.width, physicalSize.height);

    }
    return self;
}

@end
