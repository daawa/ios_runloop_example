//
//  PTInputSourceThread.m
//  NSThreadExample
//
//  Created by Haoran Chen on 6/19/13.
//  Copyright (c) 2013 KiloApp. All rights reserved.
//

#import "PTInputSourceThread.h"
#import "PTInputSource.h"

@interface PTInputSourceThread() <NSPortDelegate>

@property (nonatomic, readwrite, retain) RunLoopSource *source;

@end
@implementation PTInputSourceThread

- (void)main
{
    @autoreleasepool
    {
        NSLog(@"starting thread.......");
        
        NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
        _source = [[RunLoopSource alloc] init];
        [_source addToCurrentRunLoop];
        
        if (_outPort) {
            [self sendCheckinMessage:_outPort];
        }
                
        while (! self.isCancelled)
        {
            [self doOtherTask];

            BOOL ret = [myRunLoop runMode:NSDefaultRunLoopMode
                                                beforeDate:[NSDate distantFuture]];
            NSLog(@"exiting runloop.........: %d", ret);
        }
        NSLog(@"finishing thread.........");
    }
}

- (void)doOtherTask
{
    NSLog(@"do other task");
}

- (void)sendCheckinMessage:(NSPort*)outPort
{
    // Retain and save the remote port for future use.
    self.outPort = outPort;
    // Create and configure the worker thread port.
    NSPort* myPort = [NSMachPort port];
    [myPort setDelegate:self];
    [[NSRunLoop currentRunLoop] addPort:myPort forMode:NSDefaultRunLoopMode];
    // Create the check-in message.
    /*
     注意：虽然有这么棒的方式实现线程间通讯方式，但是估计是由于危及iOS的Sandbox沙盒环境，所以这些API都是私有接口，如果你用到NSPortMessage，XCode会提示'NSPortMessage' for instance message is a forward declaration
     */
    /*
    NSPortMessage* messageObj = [[NSPortMessage alloc] initWithSendPort:outPort
                                                            receivePort:myPort components:nil];
    if (messageObj)
    {
        // Finish configuring the message and send it immediately.
        [messageObj setMsgId:setMsgid:kCheckinMessage];
        [messageObj sendBeforeDate:[NSDate date]];
    } */
}

-(void)handlePortMessage:(NSPortMessage *)message{
    NSLog(@" handle port message ");
}


@end
