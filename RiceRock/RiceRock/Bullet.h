//
//  Bullet.h
//  RiceRock
//
//  Created by Wen Xu on 3/22/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Bullet : SKSpriteNode
@property double lifetime;
-(instancetype) initWithImage: (UIImage*) shot lifetime: (double) lifetime;
@end
