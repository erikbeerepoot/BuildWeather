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
        
        /* Animation origin depends on velocity. 4 cases:
         * vel x: | vel y: |    origin   |
         * ===============================
         *    -       -      top right
         *    -       +      bottom right
         *    +       -      top left
         *    +       +      bottom left
         */
        _velocity = NSMakePoint(1.0, 0);
        _animationOrigin.x = (_velocity.x < FLT_EPSILON) ? _drawRect.origin.x :
            (_drawRect.origin.x + (_velocity.x < 0.0 ? 1 : -1) * _imageToDraw.size.width);
        
        _animationOrigin.x = (_velocity.y < FLT_EPSILON) ? _drawRect.origin.y :
            (_drawRect.origin.y + (_velocity.y < 0.0 ? 1 : -1) * _imageToDraw.size.height);
        
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
    if( _velocity.x < FLT_EPSILON && _velocity.y < FLT_EPSILON) return;

    static long frameCount = 0;
    
    //1. Check if we're out-of-bounds
    if(NSPointInRect(_drawPoint,_drawRect)){
        _drawPoint = _animationOrigin;
    }
    
    
    //2. compute the dirty rect
    
    //3. increment frame number
    frameCount++;
}


@end
