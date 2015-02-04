//
//  AnimatedImage.h
//  BuildWeather
//
//  Created by Erik E. Beerepoot on 2015-02-04.
//  Copyright (c) 2015 Mediacore Technologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

/**
 *  Implements an animated image
 */
@interface AnimatedImage : NSObject

@property (nonatomic) NSPoint velocity;

-(id)initWithRect:(NSRect)rect andImage:(NSImage*)image ;

@end

