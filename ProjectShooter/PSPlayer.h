//
//  PSPlayer.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSScreenElement.h"

//Abstract class for any character (protagonist and antagonist)
@interface PSPlayer : PSScreenElement

//flips the image when facing the wrong direction
-(void)flipImage;

@end
