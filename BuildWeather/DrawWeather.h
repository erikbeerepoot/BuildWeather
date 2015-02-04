//
//  DrawWeather.h
//  BuildWeather
//
//  Created by Erik E. Beerepoot on 2015-02-03.
//  Copyright (c) 2015 Mediacore Technologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawWeather : NSObject
-(void)drawSunnyWeatherInRect:(NSRect)rect;
-(void)drawPartlyCloudWeatherInRect:(NSRect)rect;
-(void)drawCloudyWeatherInRect:(NSRect)rect;
-(void)drawStormyWeatherInRect:(NSRect)rect;
-(void)drawBuildStatusOverlayInRect:(NSRect)rect;
@end
