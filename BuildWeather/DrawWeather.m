//
//  DrawWeather.m
//  BuildWeather
//
//  Created by Erik E. Beerepoot on 2015-02-03.
//  Copyright (c) 2015 Mediacore Technologies Inc. All rights reserved.
//

#import "DrawWeather.h"
#import <AppKit/AppKit.h>

@implementation DrawWeather

/************************************************
 *              Color Defitinions               *
 ************************************************/


//Colors for sunny weather
const float kSkyLightBlue[4] = {0.3019,0.5882,0.7490,1.0};
const float kSkyBlue[4] = {0.1764,0.53033,0.7872,1.0};
const float kHappyYellow[4] = {0.9176, 0.8667, 0.2470, 1.0};

NSColor* skyLightBlue;
NSColor* skyBlue;
NSColor* happyYellow;



-(id)init {
    if(self = [super init]){
        //setup colors
        happyYellow = [NSColor colorWithCalibratedRed:kHappyYellow[0] green:kHappyYellow[1] blue:kHappyYellow[2] alpha:kHappyYellow[3]];
        skyBlue = [NSColor colorWithCalibratedRed:kSkyBlue[0] green:kSkyBlue[1] blue:kSkyBlue[2] alpha:kSkyBlue[3]];
        skyLightBlue = [NSColor colorWithCalibratedRed:kSkyLightBlue[0] green:kSkyLightBlue[1] blue:kSkyLightBlue[2] alpha:kSkyLightBlue[3]];
    }
    return self;
}


/**
 *  Draw a background depicting sunny skies!
 */
-(void)drawSunnyWeatherInRect:(NSRect)rect {
    //1a. create background gradient
    NSGradient *sunGradient = [[NSGradient alloc] initWithColorsAndLocations:[NSColor whiteColor],0.0, skyLightBlue,0.25,skyBlue,1.0,nil];
    
    //1. Draw the gradient with the sun in the left-uppermost corner
    [sunGradient drawInRect:rect relativeCenterPosition:NSMakePoint(-1.0, 1.0)];
    
    //2. move cloud across sky
}

/**
 *  Draws a background depicting partially cloudy weather
 */
-(void)drawPartlyCloudWeatherInRect:(NSRect)rect {
    //1. create background gradient
    
    //2. move a few clouds across sky
}

/**
 *  Draws a background depicting cloudy weather
 */
-(void)drawCloudyWeatherInRect:(NSRect)rect {
    //1. create background gradient
    
    //2. move lots of clouds
}

/**
 *  Draws a background depicting stormy weather
 */
-(void)drawStormyWeatherInRect:(NSRect)rect {
    //1. create background gradient
    
    //2. move tons of clouds across the sky with lightning
}

/**
 *  Draws the UI overlay displaying all the information
 */
-(void)drawBuildStatusOverlayInRect:(NSRect)rect {
    
}
@end
