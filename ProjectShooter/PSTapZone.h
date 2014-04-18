//
//  PSTapZone.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 4/17/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSScreenElement.h"

//A non UI class that is used to recieve taps (non held touches). Similar to UITapGestureRecognizer. Actually practically the same thing. Also, it is static so the touch bounds don't change.
@interface PSTapZone : PSScreenElement

//When touchBounds is tapped, selector is sent to target 
-(instancetype)initWithGameManager:(PSGameManager *)gameManager andTouchBounds:(CGRect)touchBounds andTarget:(id)target andSelector:(SEL)selector;

@end
