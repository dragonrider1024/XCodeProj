//
//  main.m
//  RiceRock
//
//  Created by Wen Xu on 3/19/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "Ship.h"
#import "Sprite.h"
#import "ImageInfo.h"

//global variables declarition

ImageInfo* debrisinfo;
UIImage* debris;
ImageInfo* nebulainfo;
UIImage* nebula;
ImageInfo* splashinfo;
UIImage* splash;
ImageInfo* shipinfo;
UIImage* ship_on;
UIImage* ship_off;
ImageInfo* bulletinfo;
UIImage* bullet;
ImageInfo* asteroidinfo;
UIImage* asteroid;
ImageInfo* explosioninfo;
UIImage* explosion;
AVAudioPlayer* soundtrack;
AVAudioPlayer* shotsound;
AVAudioPlayer* thrustsound;
AVAudioPlayer* explosionsound;
int score = 0;
int lives = 3;
Ship* ship;
Sprite* nebulanode;
NSMutableSet* bulletgroup;
NSMutableSet* asteroidgroup;
ImageInfo* explosioninfo;
UIImage* explosion;
AVAudioPlayer* explosion_sound;
NSMutableArray* explosionTexture;


int main(int argc, char * argv[]) {
    debrisinfo = [[ImageInfo alloc] init];
    debris = [UIImage imageNamed:@"debris2_blue"];
    nebulainfo = [[ImageInfo alloc] init];
    nebula = [UIImage imageNamed:@"nebula_blue.f2014"];
    splashinfo = [[ImageInfo alloc] init];
    splash = [UIImage imageNamed:@"splash"];
    shipinfo = [[ImageInfo alloc] init];
    shipinfo.radius = 35.0;
    UIImage* double_ship = [UIImage imageNamed:@"double_ship"];
    CGRect rect_off = CGRectMake(0, 0, double_ship.size.width / 2, double_ship.size.height);
    CGImageRef imageRef_off = CGImageCreateWithImageInRect([double_ship CGImage], rect_off);
    ship_off = [UIImage imageWithCGImage:imageRef_off];
    CGImageRelease(imageRef_off);
    //ship with thrust on
    CGRect rect_on = CGRectMake(double_ship.size.width / 2, 0, double_ship.size.width / 2, double_ship.size.height);
    CGImageRef imageRef_on = CGImageCreateWithImageInRect([double_ship CGImage], rect_on);
    ship_on = [UIImage imageWithCGImage:imageRef_on];
    CGImageRelease(imageRef_on);
    bulletinfo = [[ImageInfo alloc] init];
    bulletinfo.radius = 3.0;
    bulletinfo.lifespan = 0.005;
    bullet = [UIImage imageNamed: @"shot"];
    asteroidinfo = [[ImageInfo alloc] init];
    asteroidinfo.lifespan = 0x100000000 * 1.0;
    asteroidinfo.radius = 40.0;
    asteroid = [UIImage imageNamed:@"asteroid_blue"];
    NSString *soundtrackfilepath = [NSString stringWithFormat:@"%@/soundtrack.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundtrackurl = [NSURL fileURLWithPath:soundtrackfilepath];
    soundtrack = [[AVAudioPlayer alloc] initWithContentsOfURL:soundtrackurl error:nil];
    NSString *shotfilepath = [NSString stringWithFormat:@"%@/missile.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *shoturl = [NSURL fileURLWithPath:shotfilepath];
    shotsound = [[AVAudioPlayer alloc] initWithContentsOfURL: shoturl error:nil];
    NSString *thrustfilepath = [NSString stringWithFormat:@"%@/thrust.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *thrusturl = [NSURL fileURLWithPath:thrustfilepath];
    thrustsound = [[AVAudioPlayer alloc] initWithContentsOfURL: thrusturl error:nil];
    ship = [[Ship alloc] initWithImage: ship_off withImageInfo: shipinfo];
    bulletgroup = [[NSMutableSet alloc] init];
    asteroidgroup = [[NSMutableSet alloc] init];
    explosioninfo = [[ImageInfo alloc] init];
    explosioninfo.radius = 17;
    explosioninfo.lifespan = 0.024;
    explosioninfo.animated = true;
    explosion = [UIImage imageNamed:@"explosion_alpha"];
    NSString *explosionfilepath = [NSString stringWithFormat:@"%@/explosion.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *explosionurl = [NSURL fileURLWithPath:explosionfilepath];
    explosion_sound = [[AVAudioPlayer alloc] initWithContentsOfURL: explosionurl error:nil];
    explosionTexture = [[NSMutableArray alloc] init];
    for (int i = 0; i < 24; i ++) {
        CGRect rect = CGRectMake(explosion.size.width / 24 * i, 0, explosion.size.width / 24, explosion.size.height);
        CGImageRef recti = CGImageCreateWithImageInRect([explosion CGImage], rect);
        UIImage* explosionImage_i = [UIImage imageWithCGImage: recti];
        CGImageRelease(recti);
        [explosionTexture addObject: [SKTexture textureWithImage: explosionImage_i]];
    }
    
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
