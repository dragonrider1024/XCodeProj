//
//  asteroid.m
//  RiceRock
//
//  Created by Wen Xu on 3/22/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import "asteroid.h"
#import "Ship.h"

@implementation Asteroid

-(instancetype) initWithImage:(UIImage*) asteroid {
    if (self == [super initWithTexture: [SKTexture textureWithImage: asteroid]]) {
        self.angularspeed = 0.5;
        float rndValue = (((float)arc4random()/0x100000000)*3.1415926);
        self.movedirection = rndValue;
    }
    
    return self;
}

@end
