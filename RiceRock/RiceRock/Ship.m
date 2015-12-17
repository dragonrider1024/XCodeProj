//
//  Ship.m
//  RiceRock
//
//  Created by Wen Xu on 3/24/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import "Ship.h"
#import "ImageInfo.h"
#import "Sprite.h"
#import <AVFoundation/AVFoundation.h>

extern AVAudioPlayer* thrustsound;
extern ImageInfo* bulletinfo;
extern UIImage* bullet;
extern AVAudioPlayer* shotsound;
extern UIImage* ship_on;
extern UIImage* ship_off;
extern NSMutableSet* bulletgroup;

@implementation Ship


-(instancetype)  initWithImage: (UIImage*) ship_off withImageInfo: (ImageInfo*) info {
    if (self == [super initWithTexture: [SKTexture textureWithImage: ship_off]]) {
        self.angle_vel = 0.0;
        self.thrust = false;
        self.zRotation = 0.0;
        self.radius = info.radius;
        self.vel = CGVectorMake(0,0);
    }
    return self;
}

-(void) set_thrust : (bool) on {
    self.thrust = on;
    [thrustsound prepareToPlay];
    [thrustsound play];
    if (on) {
        [thrustsound prepareToPlay];
        [thrustsound play];
    }
    else {
        [thrustsound stop];
    }
}

-(void) increment_angle_vel {
    self.angle_vel += 0.05;
}

-(void) decrement_angle_vel {
    self.angle_vel -= 0.05;
}

-(void) update {
    self.zRotation += self.angle_vel;
    double xposition = self.position.x;
    double yposition = self.position.y;
    xposition += self.vel.dx;
    yposition += self.vel.dy;
    int x = (int) xposition;
    int y = (int) yposition;
    int w = (int) self.scene.frame.size.width;
    int h = (int) self.scene.frame.size.height;
    xposition = (double) (x % w);
    yposition = (double) (y % h);
    if (xposition < 0) xposition += self.scene.frame.size.width;
    if (yposition < 0) yposition += self.scene.frame.size.height;
    self.position = CGPointMake(xposition, yposition);
    double vx = self.vel.dx;
    double vy = self.vel.dy;
    if (self.thrust) {
        vx += 0.1 * cos(self.zRotation);
        vy += 0.1 * sin(self.zRotation);
    }
    vx *= 0.99;
    vy *= 0.99;
    self.vel = CGVectorMake(vx, vy);
    if (self.thrust) {
        self.texture = [SKTexture textureWithImage:ship_on];
    }
    else {
        self.texture = [SKTexture textureWithImage:ship_off];
    }
}

-(void) shoot {
    Sprite* a_bullet = [[Sprite alloc] initWithImage: bullet info: bulletinfo sound: shotsound];
    double xposition = self.position.x + self.radius * cos(self.zRotation);
    double yposition = self.position.y + self.radius * sin(self.zRotation);
    a_bullet.position = CGPointMake(xposition, yposition);
    double vx = self.vel.dx + 6.0 * cos(self.zRotation);
    double vy = self.vel.dy + 6.0 * sin(self.zRotation);
    a_bullet.vel = CGVectorMake(vx, vy);
    [bulletgroup addObject: a_bullet];
    [self.scene addChild: a_bullet];
}

-(void) draw:(SKScene *)sc {
    [sc addChild: self];
}
@end
