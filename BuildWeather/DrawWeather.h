#import <Foundation/Foundation.h>
#import "Scene.h"

@interface DrawWeather : NSObject

@property (readonly,retain) Scene *currentScene;
@property (readonly,retain) Scene *lastScene;

-(void)drawSunnyWeatherInRect:(NSRect)rect;
-(void)drawPartlyCloudWeatherInRect:(NSRect)rect;
-(void)drawCloudyWeatherInRect:(NSRect)rect;
-(void)drawStormyWeatherInRect:(NSRect)rect;
-(void)runWeatherAnimation:(NSRect)rect;
@end
