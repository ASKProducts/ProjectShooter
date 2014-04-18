//
//  PSGameViewController.h
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PSGameManager;
@interface PSGameViewController : UIViewController

//The game manager that manages the game logic
@property PSGameManager *gameManager;

@end
