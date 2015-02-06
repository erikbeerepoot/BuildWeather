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
 * @name: BuildWeatherView.m
 * @author: Erik E. Beerepoot
 * @company: Barefoot Inc.
 * @brief: Root view class for the application.
 */

#import "BuildWeatherView.h"
#import "BuildStatus.h"
#import "DrawWeather.h"

@implementation BuildWeatherView

DrawWeather *weatherDrawer;

+(NSBackingStoreType)backingStoreType {
    return NSBackingStoreBuffered;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        //Enable support for CoreAnimation
        self.wantsLayer = true;
        self.layerContentsRedrawPolicy = NSViewLayerContentsRedrawCrossfade;
        
        [self setAnimationTimeInterval:1/30.0];
        weatherDrawer = [[DrawWeather alloc] init];
    }
    return self;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    static BOOL firstTime = true;
    
    [super drawRect:rect];

    //DEBUG: Here until we get proper transition logic
    if(firstTime) {
        [weatherDrawer drawSunnyWeatherInRect:rect];
        firstTime=false;
    }
    
    [weatherDrawer runWeatherAnimation:rect];
}

- (void)animateOneFrame
{
    [self setNeedsDisplay:YES];
    return;
}

- (BOOL)hasConfigureSheet
{
    return NO;
}

- (NSWindow*)configureSheet
{
    return nil;
}




@end
