//
//  PSPlayer.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSPlayer.h"

@implementation PSPlayer

-(void)flipImage{
    UIImageOrientation newOrientation = ((self.view.image.imageOrientation == UIImageOrientationUp)
                                         ? UIImageOrientationUpMirrored : UIImageOrientationUp);
    
    UIImage* flippedImage = [UIImage imageWithCGImage:self.view.image.CGImage
                                                scale:self.view.image.scale
                                          orientation:newOrientation];
    self.view.image = flippedImage;
}

@end
