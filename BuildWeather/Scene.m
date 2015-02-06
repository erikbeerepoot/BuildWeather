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
 * @name: Scene.m
 * @author: Erik E. Beerepoot
 * @company: Barefoot Inc.
 * @brief: Scene class. Used to represent a weather scene (or any scene with a gradient background an animated images)
 */

#import "Scene.h"

@implementation Scene


-(id)init {
    if(self=[super init]){
        _animatedImages = [[NSMutableArray alloc] init];
    }
    return self;
}

/**
 *  Add an animated image to our private collection
 *
 *  @param animatedImage - An animated image to add
 */
-(void)addAnimatedImage:(AnimatedImage*)animatedImage{
    if(animatedImage==nil) return;
    [_animatedImages addObject:animatedImage];
}

/**
 *  Remove an animated image from our private collection
 *
 *  @param animatedImage The image
 */
-(void)removeAnimatedImage:(AnimatedImage*)animatedImage{
    if(animatedImage==nil) return;
    [_animatedImages removeObject:animatedImage];
}

/**
 *  Clears the private collection of animated images
 */
-(void)removeAllAnimatedImages{
    [_animatedImages removeAllObjects];
}

@end
