//
//  PTInputSourceThread.h
//  NSThreadExample
//
//  Created by Haoran Chen on 6/19/13.
//  Copyright (c) 2013 KiloApp. All rights reserved.
//
#define kCheckinMessage 100

#import <Foundation/Foundation.h>

@interface PTInputSourceThread : NSThread

@property (nonatomic, strong) NSPort *outPort;

@end
