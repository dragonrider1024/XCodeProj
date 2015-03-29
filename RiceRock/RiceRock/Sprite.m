//
//  Sprite.m
//  RiceRock
//
//  Created by Wen Xu on 3/24/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import "Sprite.h"
#import "Ship.h"
extern Ship* ship;

@implementation Sprite

-(instancetype) initWithImage:(UIImage *)image info:(ImageInfo *)info sound:(AVAudioPlayer *)sound {
    if(self == [super initWithTexture: [SKTexture textureWithImage: image]]) {
        self.angle_vel = 0.0;
        self.radius = info.radius;
        self.lifespan = info.lifespan;
        self.animated = info.animated;
        self.age = 0.0;
        if (sound != nil) {
            [sound prepareToPlay];
            [sound play];
        }
        self.vel = CGVectorMake(0,0);
    }
    return self;
}

-(bool) update {
    self.zRotation += self.angle_vel;
    double xposition = self.position.x;
    double yposition = self.position.y;
    xposition += self.vel.dx;
    yposition += self.vel.dy;
    int x = (int) xposition;
    int y = (int) yposition;
    int w = (int) ship.scene.size.width;
    int h = (int) ship.scene.size.height;
    xposition = (double) (x % w);
    yposition = (double) (y % h);
    if (xposition < 0) xposition += ship.scene.size.width;
    if (yposition < 0) yposition += ship.scene.size.height;
    self.position = CGPointMake(xposition, yposition);
    self.age += 0.0001;
    if (self.age <= self.lifespan) {
        return false;
    }
    else {
        return true;
    }
}

-(bool) collide:(SKSpriteNode*) s {
    double xdiff = self.position.x - s.position.x;
    double ydiff = self.position.y - s.position.y;
    double distance = sqrt(xdiff * xdiff + ydiff * ydiff);
    double sradius = 0;
    if ([s class] == [Ship class]) sradius = ((Ship*) s).radius;
    if ([s class] == [Sprite class]) sradius = ((Sprite*) s).radius;
    if (distance <= self.radius + sradius) {
        return true;
    }
    else {
        return false;
    }
}

-(void) draw:(SKScene *)sc {
    [sc addChild: self];
}

@end
