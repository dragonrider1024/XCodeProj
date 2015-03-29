//
//  Sprite.h
//  RiceRock
//
//  Created by Wen Xu on 3/24/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "imageInfo.h"

@interface Sprite : SKSpriteNode
@property CGVector vel;
@property double angle_vel;
@property double radius;
@property double lifespan;
@property bool animated;
@property double age;
@property  AVAudioPlayer* sound;

-(instancetype) initWithImage: (UIImage*) image info:(ImageInfo*) info sound: (AVAudioPlayer*) sound;
-(bool) update;
-(bool) collide : (SKSpriteNode*) s;
-(void) draw: (SKScene*) sc;
@end
