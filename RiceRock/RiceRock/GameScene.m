//
//  GameScene.m
//  RiceRock
//
//  Created by Wen Xu on 3/19/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>
#import "Ship.h"
#import "Sprite.h"

extern ImageInfo* debrisinfo;
extern UIImage* debris;
extern ImageInfo* nebulainfo;
extern UIImage* nebula;
extern ImageInfo* splashinfo;
extern UIImage* splash;
extern ImageInfo* shipinfo;
extern UIImage* ship_on;
extern UIImage* ship_off;
extern ImageInfo* bulletinfo;
extern UIImage* bullet;
extern ImageInfo* asteroidinfo;
extern UIImage* asteroid;
extern ImageInfo* explosioninfo;
extern UIImage* explosion;
extern AVAudioPlayer* soundtrack;
extern AVAudioPlayer* shotsound;
extern AVAudioPlayer* thrustsound;
extern AVAudioPlayer* explosionsound;
extern int score;
extern int lives;
extern NSMutableSet* bulletgroup;
extern NSMutableSet* asteroidgroup;
extern Ship* ship;
extern AVAudioPlayer* explosion_sound;


@implementation GameScene {
    Sprite* splashnode;
}

-(void)didMoveToView:(SKView *)view {
    
    //load and add background nebula
    Sprite* nebulanode = [[Sprite alloc] initWithImage: nebula info: nebulainfo sound: soundtrack];
    nebulanode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    nebulanode.size = self.size;
    [nebulanode draw: self];

    //load and add the debris
    Sprite* debrisnode = [[Sprite alloc] initWithImage: debris info: debrisinfo sound: nil];
    debrisnode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    debrisnode.size = self.size;
    [debrisnode draw: self];
    
    //load add splash screen
    splashnode = [[Sprite alloc] initWithImage: splash info: splashinfo sound: nil];
    splashnode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [splashnode draw: self];

    // load and add the ship
    ship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [ship draw:self];



    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    // remove the splash screen
    if (splashnode != nil) {
        [splashnode removeFromParent];
    }
    //stop the background sound
    if (soundtrack.isPlaying) {
        [soundtrack stop];
    }
    
    for (UITouch* atouch in touches) {
        if (atouch.tapCount == 1) {
            //single tap
            CGPoint location = [atouch locationInNode:self];
            //calculate and set the rotation needed for the ship
            if (fabs(location.x - ship.position.x) < 1E-6) {
                if (location.y > ship.position.y) {
                    ship.zRotation = 3.1415926 / 2;
                }
                else {
                    ship.zRotation = -3.1415926 / 2;
                }
            }
            else {
                ship.zRotation = atan((location.y - ship.position.y) / (location.x - ship.position.x));
                if (location.y < ship.position.y && ship.zRotation > 0) ship.zRotation += 3.1415926;
                if (location.y > ship.position.y && ship.zRotation < 0) ship.zRotation -= 3.1415926;
            }
            [ship set_thrust: true];
        }
        else if (atouch.tapCount >= 2) {
        //double tap
        [ship shoot];
        }
        else {
            continue;
        }
    }
}


-(void) touchesEnded:(NSSet*) touches withEvent:(UIEvent*) event {
    for(UITouch *atouch in touches) {
        //single tap
        if (atouch.tapCount == 1) {
            [ship performSelector:@selector(set_thrust:) withObject:false afterDelay:1.0];
        }
        else {
            continue;
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    // update the ship position
    [ship update];
    if(asteroidgroup.count < 12) {
        [self rock_spawner];
    }
    if ([self group_collide: asteroidgroup sprite: ship]) {
        lives -= 1;
    }
    score += [self group_group_collide: asteroidgroup missile_group: bulletgroup];
    
    //update the bullet and asteroid position
    [self process_sprite_group:bulletgroup];
    [self process_sprite_group:asteroidgroup];

}

-(void) process_sprite_group: (NSMutableSet*) sprite_group {
    for (Sprite* sprite in sprite_group) {
        [sprite update];
    }
}

-(bool) group_collide :(NSMutableSet*) group sprite: (SKSpriteNode*) sprite {
    NSMutableSet* rm = [[NSMutableSet alloc] init];
    for (Sprite* s in group) {
        if ([s update]) {
            [rm addObject: s];
        }
    }
    
    for(Sprite* s in rm) {
        [group removeObject: s];
        [s removeFromParent];
    }
    
    rm = [[NSMutableSet alloc] init];
    for (Sprite* s in group) {
        if ([s collide: sprite]){
            [rm addObject: s];
        }
    }
    if (rm.count == 0) {
        return false;
    }
    else {
        for(Sprite* s in rm) {
            [group removeObject: s];
            [s removeFromParent];
            [explosion_sound prepareToPlay];
            [explosion_sound play];
        }
        return true;
    }
}

-(int) group_group_collide: (NSMutableSet*) rock_group missile_group: (NSMutableSet*) missile_group {
    int missile_collections = 0;
    NSMutableSet* rm = [[NSMutableSet alloc] init];
    for (Sprite* missile in missile_group) {
        if ([missile update]) {
            [rm addObject: missile];
        }
    }
    for(Sprite* s in rm) {
        [missile_group removeObject: s];
        [s removeFromParent];
    }
    rm = [[NSMutableSet alloc] init];
    for (Sprite* missile in missile_group) {
        if ([self group_collide: rock_group sprite: missile]) {
            missile_collections += 1;
            [rm addObject: missile];
        }
    }
    for(Sprite* s in rm) {
        [missile_group removeObject: s];
        [s removeFromParent];
    }
    return missile_collections;
}

-(void) rock_spawner {
    Sprite* asteroidnode;
    asteroidnode = [[Sprite alloc] initWithImage: asteroid info: asteroidinfo sound: nil];
    double x = (double)arc4random() / 0x100000000* self.size.width;
    double y = (double)arc4random() / 0x100000000 * self.size.height;
    asteroidnode.position = CGPointMake(x,y);
    double vx = (((double)arc4random()/0x100000000)*5) - 2.5;
    double vy = (((double)arc4random()/0x100000000)*5) - 2.5;
    double avel =  (((double)arc4random()/0x100000000)*0.4) - 0.2;
    asteroidnode.vel = CGVectorMake(vx, vy);
    asteroidnode.angle_vel = avel;
    [asteroidgroup addObject: asteroidnode];
    [self addChild: asteroidnode];
}


@end
