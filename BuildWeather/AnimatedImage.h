#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

/**
 *  Implements an animated image
 */
@interface AnimatedImage : NSObject

@property (nonatomic) NSPoint velocity;
@property (nonatomic) NSInteger delay;
@property (nonatomic,readonly) BOOL done;
@property (nonatomic) BOOL repeat;

-(id)initWithRect:(NSRect)rect andImage:(NSImage*)image ;
-(void)animate;
@end

