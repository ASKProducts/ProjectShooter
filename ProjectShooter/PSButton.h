//
//  PSButton.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/17/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSScreenElement.h"

@class PSButton;
@protocol PSButtonReciver <NSObject>

@optional

-(void)buttonDown:(PSButton*)button;
-(void)buttonUp:(PSButton*)button;

@end

//A class to represent the buttons on the screen. It is in theory static but the touchBounds follow the view property so it could be moved
@interface PSButton : PSScreenElement

@property (readonly) BOOL isPressed;

@property UIImage *normalImage;
@property UIImage *pressedImage;

@property id<PSButtonReciver> reciever;

-(instancetype)initWithGameManager:(PSGameManager *)gameManager andReciever:(id<PSButtonReciver>)reciever andBounds:(CGRect)bounds andNormalImage:(UIImage*)normalImage andPressedImage:(UIImage*)pressedImage;


@end

