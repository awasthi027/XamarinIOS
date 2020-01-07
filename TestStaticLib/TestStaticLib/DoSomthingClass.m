//
//  DoSomthingClass.m
//  TestStaticLib
//
//  Created by Ashish Awasthi on 07/01/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

#import "DoSomthingClass.h"

@implementation DoSomthingClass
- (void)doSomthingNew:(NSString *)from {
    NSLog(@"Call from where:-%@",from);
    if ([self.delegate respondsToSelector:@selector(callBackFromTestLib)]) {
        [self.delegate callBackFromTestLib];
    }
}

@end
