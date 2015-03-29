//
//  Ship.h
//  RiceRock
//
//  Created by Wen Xu on 3/24/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "imageInfo.h"

@interface Ship : SKSpriteNode
@property CGVector vel;
@property double angle_vel;
@property double radius;
@property bool thrust;

-(instancetype) initWithImage: (UIImage*) ship_off withImageInfo: (ImageInfo*) info;
-(void) increment_angle_vel;
-(void) decrement_angle_vel;
-(void) shoot;
-(void) update;
-(void) set_thrust: (bool) on;
-(void) draw : (SKScene*) sc;
@end
