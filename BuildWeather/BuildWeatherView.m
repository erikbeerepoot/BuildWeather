//
//  BuildWeatherView.m
//  BuildWeather
//
//  Created by Erik E. Beerepoot on 2015-02-03.
//

#import "BuildWeatherView.h"
#import "BuildStatus.h"
#import "DrawWeather.h"

@implementation BuildWeatherView

DrawWeather *weatherDrawer;


- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
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
    [super drawRect:rect];
    
    //depending on the weather, decide which drawing function to call
    [weatherDrawer drawSunnyWeatherInRect:rect];
}

- (void)animateOneFrame
{ 
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
