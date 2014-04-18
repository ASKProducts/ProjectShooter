//
//  PSGameViewController.m
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/20/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import "PSGameViewController.h"
#import "PSGameManager.h"
#import "Definitions.h"

@interface PSGameViewController ()

@end

@implementation PSGameViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.gameManager = [[PSGameManager alloc] initWithViewController:self
                                                           isMultiplayer:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.gameManager setUpScreen];
    [self.gameManager play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touch Input Handling

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        [self.gameManager registerTouch:touch];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        [self.gameManager registerTouch:touch];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        [self.gameManager registerTouch:touch];
    }
}

#pragma mark - autorotation

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate {
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
