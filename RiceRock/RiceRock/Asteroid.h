//
//  asteroid.h
//  RiceRock
//
//  Created by Wen Xu on 3/22/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Asteroid : SKSpriteNode
@property double angularspeed;
@property double movedirection;
-(instancetype) initWithImage: (UIImage*) asteroid;
@end
