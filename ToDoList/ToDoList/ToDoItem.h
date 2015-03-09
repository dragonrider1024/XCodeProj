//
//  ToDoItem.h
//  ToDoList
//
//  Created by Wen Xu on 3/9/15.
//  Copyright (c) 2015 Aerodyne Research, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property NSString *itemName;
@property BOOL completed;
@property (readonly) NSDate * creationDate;

@end
