//
//  ImageInfo.h
//  RiceRock
//
//  Created by Wen Xu on 3/24/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>

@interface ImageInfo : NSObject

@property CGPoint center;
@property CGPoint size;
@property double radius;
@property double lifespan;
@property bool animated;

-(CGPoint) get_center;
-(CGPoint) get_size;
-(double) get_radius;
-(double) get_lifespan;
-(bool) get_animated;
@end
