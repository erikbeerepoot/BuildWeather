#import <Foundation/Foundation.h>

@interface DrawWeather : NSObject
-(void)drawSunnyWeatherInRect:(NSRect)rect;
-(void)drawPartlyCloudWeatherInRect:(NSRect)rect;
-(void)drawCloudyWeatherInRect:(NSRect)rect;
-(void)drawStormyWeatherInRect:(NSRect)rect;
-(void)drawBuildStatusOverlayInRect:(NSRect)rect;
@end
