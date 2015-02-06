/*
 *      ___           ___           ___           ___                         ___           ___
 *     /  /\         /  /\         /  /\         /  /\          ___          /  /\         /  /\          ___
 *    /  /::\       /  /::\       /  /::\       /  /::\        /  /\        /  /::\       /  /::\        /__/\
 *   /  /:/\:\     /  /:/\:\     /  /:/\:\     /  /:/\:\      /  /::\      /  /:/\:\     /  /:/\:\       \  \:\
 *  /  /::\ \:\   /  /::\ \:\   /  /::\ \:\   /  /::\ \:\    /  /:/\:\    /  /:/  \:\   /  /:/  \:\       \__\:\
 * /__/:/\:\_\:| /__/:/\:\_\:\ /__/:/\:\_\:\ /__/:/\:\ \:\  /  /::\ \:\  /__/:/ \__\:\ /__/:/ \__\:\      /  /::\
 * \  \:\ \:\/:/ \__\/  \:\/:/ \__\/~|::\/:/ \  \:\ \:\_\/ /__/:/\:\ \:\ \  \:\ /  /:/ \  \:\ /  /:/     /  /:/\:\
 *  \  \:\_\::/       \__\::/     |  |:|::/   \  \:\ \:\   \__\/  \:\_\/  \  \:\  /:/   \  \:\  /:/     /  /:/__\/
 *   \  \:\/:/        /  /:/      |  |:|\/     \  \:\_\/        \  \:\     \  \:\/:/     \  \:\/:/     /__/:/
 *    \__\::/        /__/:/       |__|:|~       \  \:\           \__\/      \  \::/       \  \::/      \__\/
 *        ~~         \__\/         \__\|         \__\/                       \__\/         \__\/
 * @name: AnimatedImage.m
 * @author: Erik E. Beerepoot
 * @company: Barefoot Inc.
 * @brief: This class is used to represent and animate an NSImage moving across the screen horizontally, left or right.
 */
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
        _delay = 0;
        _done = NO;
        _repeat = NO;
        
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
        if(fabs(_velocity.x) < FLT_EPSILON){
            //draw at the origin (i.e. just show image)
            _animationOrigin.x = 1 + _drawRect.origin.x;
            _animationOrigin.y = 1 + _drawRect.origin.y;
        } else if(_velocity.x < 0){
            //start by setting image offscreen on the right side of the screen
            _animationOrigin.x = 1 + (_drawRect.size.width);
            _animationOrigin.y = 1 + (_drawRect.origin.y);
        } else {
            //start by setting the image offscreen on the left size of the screen
            _animationOrigin.x = 1 + (_drawRect.origin.x - + _imageToDraw.size.width);
            _animationOrigin.y = 1 + (_drawRect.origin.y);
        }
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
    static frameCount = 0;

    if(frameCount < self.delay) return;
    if(_done || (fabs(_velocity.x)<FLT_EPSILON  && fabs(_velocity.y) < FLT_EPSILON)) return;
    
    //1. Check if we're in bounds
    CGRect intersection = CGRectIntersection(CGRectMake(_drawPoint.x, _drawPoint.y, _imageToDraw.size.width,_imageToDraw.size.height),_drawRect);
    
    //Only draw if we have content in bounds
    if(!CGRectIsNull(intersection)){
        //2. compute the dirty rect
        _dirtyRect = intersection;
        
        
        NSPoint origin;
        
        //Depending on direction of motion, we must copy different parts of the image
        NSRect copyRect = intersection;
        if(_velocity.x > 0){
            origin.x = (_drawPoint.x > _drawRect.size.width ? _drawRect.size.width : (_drawPoint.x < 0 ? 0.0 : _drawPoint.x));
            origin.y = (_drawPoint.y > _drawRect.size.height ? _drawRect.size.height : (_drawPoint.y < 0 ? 0.0 : _drawPoint.y));
            
            //copy rect starts on the right edge of the image, expands left
            if((_drawPoint.x + _imageToDraw.size.width) < _drawRect.size.width){
                copyRect.origin.x = _imageToDraw.size.width - _dirtyRect.size.width;
                copyRect.origin.y = 0;
                copyRect.size = _dirtyRect.size;
            } else {
                copyRect.origin.x = 0;
                copyRect.origin.y = 0;
                copyRect.size.width = _dirtyRect.size.width;
            }
        } else {
            if((_drawPoint.x + _imageToDraw.size.width) > 0){
                //copy rect starts on the left size of the image, expands right
                copyRect.origin.x = 0;
                copyRect.origin.y = 0;
                copyRect.size = _dirtyRect.size;
            } else {
                copyRect.origin.x = _imageToDraw.size.width - _dirtyRect.size.width;
                copyRect.origin.y = 0;
                copyRect.size = _dirtyRect.size;
            }
            origin.x = _drawRect.size.width - copyRect.size.width;
            origin.y = _drawRect.origin.y;
        }
        //draw only the part that is visible
        [_imageToDraw drawAtPoint:origin fromRect:copyRect operation:NSCompositeLuminosity fraction:0.9];
   }
    
    _drawPoint.x += _velocity.x;
    _drawPoint.y += _velocity.y;
    
    if((_velocity.x < 0 && (_drawPoint.x+_imageToDraw.size.width) < 0) ||
      (_velocity.x > 0 && (_drawPoint.x > _drawRect.size.width))){
        //reset
        if(_repeat){
            _drawPoint = _animationOrigin;
            return;
        }
        _done = YES;
    }
    frameCount++;
}


@end
