//
//  ImageInfo.m
//  RiceRock
//
//  Created by Wen Xu on 3/24/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import "ImageInfo.h"

@implementation ImageInfo

-(CGPoint) get_center {
    return self.center;
}

-(CGPoint) get_size {
    return self.size;
}

-(double) get_lifespan {
    return self.lifespan;
}

-(double) get_radius {
    return self.radius;
}

-(bool) get_animated {
    return self.animated;
}

@end
