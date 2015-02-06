//
//  WeatherScene.h
//  BuildWeather
//
//  Created by Erik E. Beerepoot on 2015-02-05.
//  Copyright (c) 2015 Mediacore Technologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

#import "AnimatedImage.h"

@interface Scene : NSObject
@property (nonatomic,retain,readonly) NSMutableArray *animatedImages;
@property (nonatomic,retain) NSGradient *backgroundGradient;
@property (nonatomic) NSPoint sunPoint;

-(void)addAnimatedImage:(AnimatedImage*)animatedImage;
-(void)removeAnimatedImage:(AnimatedImage*)animatedImage;
-(void)removeAllAnimatedImages;

@end
