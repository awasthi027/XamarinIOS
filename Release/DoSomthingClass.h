//
//  TestStaticLib.h
//  TestStaticLib
//
//  Created by Ashish Awasthi on 06/01/20.
//  Copyright © 2020 Ashish Awasthi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  DoSomthingClassDelegate<NSObject>
- (void)callBackFromTestLib;
@end
@interface DoSomthingClass : NSObject
@property(nonatomic, weak) id delegate;

- (void)doSomthing:(NSString *)from;

@end
