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
    NSRect   _dirtyRect;
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
        _dirtyRect = NSZeroRect;
        
        /* Animation origin depends on velocity. 4 cases:
         * vel x: | vel y: |    origin   |
         * ===============================
         *    -       -      top right
         *    -       +      bottom right
         *    +       -      top left
         *    +       +      bottom left
         */
        #warning velocity hardcoded here
        _velocity = NSMakePoint(1.0, 0);
        _animationOrigin.x = 1 + ((_velocity.x < FLT_EPSILON) ? _drawRect.origin.x :
            (_drawRect.origin.x + (_velocity.x < 0.0 ? 1 : -1) * _imageToDraw.size.width));
        
        _animationOrigin.y = 1 + ((_velocity.y < FLT_EPSILON) ? _drawRect.origin.y :
            (_drawRect.origin.y + (_velocity.y < 0.0 ? 1 : -1) * _imageToDraw.size.height));
        
        _drawPoint = _animationOrigin;
    }
    return self;
}




/**
 *  Returns the rect we should re-draw for this image (i.e. the "dirty" rect
 *  @return The rect that fits the above description
 */
-(NSRect)dirtyRect {
    return _dirtyRect;
}

/**
 *  Implements the logic for animating this image. The animation we do here is a simple translation, with opacity.
 */
-(void)animate {
    if( _velocity.x < FLT_EPSILON && _velocity.y < FLT_EPSILON) return;

    static long frameCount = 0;
    
    //1. Check if we're in bounds
    CGRect intersection = CGRectIntersection(CGRectMake(_drawPoint.x, _drawPoint.y, _imageToDraw.size.width,_imageToDraw.size.height),_drawRect);
    if(!CGRectIsNull(intersection)){
        //2. compute the dirty rect
        _dirtyRect = intersection;
        
        
        NSPoint origin;
        origin.x = (_drawPoint.x > _drawRect.size.width ? _drawRect.size.width : (_drawPoint.x < 0 ? 0.0 : _drawPoint.x));
        origin.y = (_drawPoint.y > _drawRect.size.height ? _drawRect.size.height : (_drawPoint.y < 0 ? 0.0 : _drawPoint.y));
        
        //Depending on direction of motion, we must copy different parts of the image

        //NO MODS COPY LEFT TO RIGHT
        //[_imageToDraw drawAtPoint:origin fromRect:_dirtyRect operation:NSCompositeLuminosity fraction:0.9];

        
        //COPY RIGHT TO LEFT
        if(
        NSRect copyRect;
        copyRect.origin.x = _imageToDraw.size.width - _dirtyRect.size.width;
        copyRect.origin.y = _dirtyRect.origin.y;
        copyRect.size = _dirtyRect.size;
        [_imageToDraw drawAtPoint:origin fromRect:copyRect operation:NSCompositeLuminosity fraction:0.9];
        
   }
    
    //4. increment frame number
    _drawPoint.x += _velocity.x;
    _drawPoint.y += _velocity.y;
    frameCount++;
}


@end
