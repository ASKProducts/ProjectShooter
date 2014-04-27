//
//  PSBomb.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSDropper.h"

//Class which represents a bomb that is dropped from a helicopter. They are destroyed by
@interface PSBomb : PSDropper

//When a bomb of size X is shot, one bomb of size X-1 or two bombs of size X-2 appear. When A bomb of size 1 is shot, it disappears.
//A bomb of size X has a physical size of BOMB_PHYSICAL_SIZE(X)

@property NSInteger size;

@end
