//
//  PSButton.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/17/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSButton.h"
#import "PSTouch.h"

@interface PSButton ()

//rewrite for full write access
@property BOOL isPressed;

@end

@implementation PSButton

-(instancetype)initWithGameManager:(PSGameManager *)gameManager andReciever:(id<PSButtonReciver>)reciever andBounds:(CGRect)bounds andNormalImage:(UIImage*)normalImage andPressedImage:(UIImage*)pressedImage{
    self = [super initWithGameManager:gameManager];
    if(self){
        self.acceptsTouches = YES;
        self.view = [[UIImageView alloc] initWithFrame:bounds]; //The default touchBounds works here
        self.reciever = reciever;
        self.normalImage = normalImage;
        self.pressedImage = pressedImage;
        self.view.image = normalImage;
    }
    return self;
}

-(void)touchBegan:(PSTouch *)touch{
    self.isPressed = YES;
    if(self.touches.count == 1){ //if this is the 'main' tap (aka only the first push really counts)
        self.view.image = self.pressedImage;
        if([self.reciever respondsToSelector:@selector(buttonDown:)])
            [self.reciever buttonDown:self];
    }
}

-(void)touchEnded:(PSTouch *)touch{
    if(self.touches.count == 0){ //only count if there is no touches left
        self.isPressed = NO;
        self.view.image = self.normalImage;
        if([self.reciever respondsToSelector:@selector(buttonUp:)])
            [self.reciever buttonUp:self];
    }
}

@end
