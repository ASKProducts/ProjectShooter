//
//  Definitions.c
//  ProjectShooter
//
//  Created by Aaron Kaufer on 3/22/14.
//  Copyright (c) 2014 Aaron Kaufer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Definitions.h"
#import "PSTouch.h"
#import <objc/runtime.h>

CGFloat CGPointDistance(CGPoint point1, CGPoint point2){
    return sqrtf((point1.x-point2.x)*(point1.x-point2.x) +
                 (point1.y-point2.y)*(point1.y-point2.y) );
}

CGPoint CGPointS(CGPoint p){
    return CGPointMake(CGFloatS_W(p.x),
                       CGFloatS_H(p.y));
}
CGPoint CGPointS_W(CGPoint p){
    return CGPointMake(CGFloatS_W(p.x),
                       CGFloatS_W(p.y));
}
CGPoint CGPointS_H(CGPoint p){
    return CGPointMake(CGFloatS_H(p.x),
                       CGFloatS_H(p.y));
}

CGSize CGSizeS(CGSize s){
    return CGSizeMake(CGFloatS_W(s.width),
                      CGFloatS_H(s.height));
}
CGSize CGSizeS_W(CGSize s){
    return CGSizeMake(CGFloatS_W(s.width),
                      CGFloatS_W(s.height));
}
CGSize CGSizeS_H(CGSize s){
    return CGSizeMake(CGFloatS_H(s.width),
                      CGFloatS_H(s.height));
}

CGRect CGRectS(CGRect r){
    CGRect rect;
    rect.origin = CGPointS(r.origin);
    rect.size = CGSizeS(r.size);
    return rect;
}
CGRect CGRectS_W(CGRect r){
    CGRect rect;
    rect.origin = CGPointS_W(r.origin);
    rect.size = CGSizeS_W(r.size);
    return rect;
}
CGRect CGRectS_H(CGRect r){
    CGRect rect;
    rect.origin = CGPointS_H(r.origin);
    rect.size = CGSizeS_H(r.size);
    return rect;
}


@implementation CALayer (playpause)

-(void)pauseLayer{
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.speed = 0.0;
    self.timeOffset = pausedTime;
}

-(void)resumeLayer{
    CFTimeInterval pausedTime = [self timeOffset];
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end


