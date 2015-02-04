//
//  AnimatedImage.m
//  BuildWeather
//
//  Created by Erik E. Beerepoot on 2015-02-04.
//  Copyright (c) 2015 Mediacore Technologies Inc. All rights reserved.
//

#import "AnimatedImage.h"

@implementation AnimatedImage
{
    NSImage *_imageToDraw;
    
    //Drawing parameters
    NSRect   _drawRect;
    NSPoint  _animationOrigin;
    NSPoint  _drawPoint;
    
}

/**
 *  Initialize a new instance of this class with the given rect in which we animate the image
 *  and the image we should be drawing.
 *  @param rect  The rect in which the image should be animated
 *  @param image The image we wish to draw
 *
 *  @return <#return value description#>
 */
-(id)initWithRect:(NSRect)rect andImage:(NSImage*)image {
    if(self = [super init]){
        _imageToDraw = [image copy];
        
        //set drawing parameters
        _drawRect = rect;
        _animationOrigin = NSMakePoint(_drawRect.origin.x - _imageToDraw.size.width,
                                    _drawRect.origin.y - _imageToDraw.size.height);
        _drawPoint = _animationOrigin;
    }
    return self;
}




/**
 *  Returns the rect we should re-draw for this image (i.e. the "dirty" rect
 *  @return The rect that fits the above description
 */
-(NSRect)dirtyRect {
    return NSZeroRect;
}

/**
 *  Implements the logic for animating this image. The animation we do here is a simple translation, with opacity.
 */
-(void)animate {
    static long frameCount = 0;
    
    //1a: Have we exceeded the bounds of the drawing rect to the right?
    if( fabs((_drawRect.origin.x + _drawRect.size.width) - _drawPoint.x) < FLT_EPSILON ||
        fabs((_drawRect.origin.y + _drawRect.size.height) - _drawPoint.y) < FLT_EPSILON){
        _drawPoint = _animationOrigin;
    }
    //1b: Have we exceeded the bounds of the drawing rect to the left?
    else if( fabs(_drawPoint.x - (_drawRect.origin.x + _drawRect.size.width)) < FLT_EPSILON ||
                  fabs(_drawPoint.y - (_drawRect.origin.y + _drawRect.size.height)) < FLT_EPSILON){
        _drawPoint = _animationOrigin;
    }
    
//
    
    //2. compute the dirty rect
    
    //3. increment frame number
    frameCount++;
}


@end
