//
//  PSBoulder.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSBoulder.h"
#import "PSHelicopter.h"
#import "Definitions.h"

@implementation PSBoulder

-(instancetype)initWithOwner:(PSHelicopter *)owner{
    self = [super initWithOwner:owner];
    if (self) {
        self.view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:BOULDER_IMAGE]];
        
        self.view.bounds = CGRectMake(0, 0, 60, 70);
    }
    return self;
}

@end
