//
//  Bullet.m
//  RiceRock
//
//  Created by Wen Xu on 3/22/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

-(instancetype) initWithImage :(UIImage*) bullet lifetime: (double) lifetime {
    if (self ==[super initWithTexture: [SKTexture textureWithImage: bullet]]) {
        self.lifetime = lifetime;
    }
    return self;
}

@end
