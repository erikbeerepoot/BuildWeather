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
 * @name: DrawWeather.m
 * @author: Erik E. Beerepoot
 * @company: Barefoot Inc.
 * @brief: This class handles the drawing & animation of different weather patterns
 */

#import "AnimatedImage.h"
#import "DrawWeather.h"
#import "Scene.h"

#import <AppKit/AppKit.h>

@implementation DrawWeather

//animation speed in pixels/frame
const float kSunnyAnimationSpeed = 1;

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

//Colors for cloudy weather
const float kLightGray[4] = {0.607,0.643,0.650,1.0};
const float kMidGray[4] = {0.204,0.204,0.204,1.0};
const float kDarkGray[4] = {0.104,0.104,0.104,1.0};

NSColor* lightGray;
NSColor* midGray;



//cloud assets
NSImage *cloud1, *cloud2, *cloud3, *cloud4;


-(id)init {
    if(self = [super init]){
        //setup colors
        happyYellow = [NSColor colorWithCalibratedRed:kHappyYellow[0] green:kHappyYellow[1] blue:kHappyYellow[2] alpha:kHappyYellow[3]];
        skyBlue = [NSColor colorWithCalibratedRed:kSkyBlue[0] green:kSkyBlue[1] blue:kSkyBlue[2] alpha:kSkyBlue[3]];
        skyLightBlue = [NSColor colorWithCalibratedRed:kSkyLightBlue[0] green:kSkyLightBlue[1] blue:kSkyLightBlue[2] alpha:kSkyLightBlue[3]];
        lightGray = [NSColor colorWithCalibratedRed:kLightGray[0] green:kLightGray[1] blue:kLightGray[2] alpha:kLightGray[3]];
        midGray = [NSColor colorWithCalibratedRed:kMidGray[0] green:kMidGray[1] blue:kMidGray[2] alpha:kMidGray[3]];

        
        
        //load clouds
        cloud1 = [[NSImage alloc] initWithContentsOfFile:@"/Users/erik/Pictures/clouds/5.jp2"];
        cloud2 = [[NSImage alloc]initWithContentsOfFile:@"/Users/erik/Desktop/2.png"];
        cloud3 = [NSImage imageNamed:@"./BuildWeather/Assets/3.png"];
        cloud4 = [NSImage imageNamed:@"./Assets/4.png"];

    }

    return self;
}


/**
 *  Draw a background depicting sunny skies!
 */
-(void)drawSunnyWeatherInRect:(NSRect)rect
{
    Scene *scene = [[Scene alloc] init];
    
    //Create scene properties
    AnimatedImage *image = [[AnimatedImage alloc] initWithRect:rect andImage:cloud1];
    NSGradient *sunGradient = [[NSGradient alloc] initWithColorsAndLocations:[NSColor whiteColor],0.0, skyLightBlue,0.25,skyBlue,1.0,nil];
    
    [scene addAnimatedImage:image];
    scene.backgroundGradient = sunGradient;
    _lastScene = _currentScene;
    _currentScene = scene;
}

/**
 *  Draws a background depicting partially cloudy weather
 */
-(void)drawPartlyCloudWeatherInRect:(NSRect)rect {
    Scene *scene = [[Scene alloc] init];
    
    //Create scene properties
  //  AnimatedImage *image = [[AnimatedImage alloc] initWithRect:rect andImage:cloud1];

    //draw second cloud above first one
    
    AnimatedImage *image2 = [[AnimatedImage alloc] initWithRect:rect andImage:cloud2];
    [scene addAnimatedImage:image2];
    
    rect.origin.y += 350;
    image2 = [[AnimatedImage alloc] initWithRect:rect andImage:cloud2];
    image2.delay = 100;
    
    rect.origin.y += 350;
    image2 = [[AnimatedImage alloc] initWithRect:rect andImage:cloud2];
    image2.delay = 500;
    
    [scene addAnimatedImage:image2];
    
    NSGradient *cloudyGradient = [[NSGradient alloc] initWithColorsAndLocations:lightGray,0.0,midGray,1.0,nil];
    
//    [scene addAnimatedImage:image];
    [scene addAnimatedImage:image2];
    scene.backgroundGradient = cloudyGradient;
    _lastScene = _currentScene;
    _currentScene = scene;
}

/**
 *  Draws a background depicting cloudy weather
 */
-(void)drawCloudyWeatherInRect:(NSRect)rect {
}

/**
 *  Draws a background depicting stormy weather
 */
-(void)drawStormyWeatherInRect:(NSRect)rect {

}

/**
 *  Draws the UI overlay displaying all the information
 */
-(void)drawBuildStatusOverlayInRect:(NSRect)rect {
    
}

/**
 *  Executes the weather animation.
 */
-(void)runWeatherAnimation:(NSRect)rect {
    if(_currentScene==nil) return;
    static int frameCount = 0;
    
    if(_lastScene!=nil || _currentScene!=_lastScene){
        //do a nice transition
    }
    
    //1. Draw the gradient in the left-uppermost corner
    [_currentScene.backgroundGradient drawInRect:rect relativeCenterPosition:NSMakePoint(-1.0, 1.0)];
    
    //2. move images across background gradient
    for(int i=0;i<_currentScene.animatedImages.count;i++){
        [[_currentScene.animatedImages objectAtIndex:i] animate];
    }

    frameCount++;
}
@end
