#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

/**
 *  Implements an animated image
 */
@interface AnimatedImage : NSObject

@property (nonatomic) NSPoint velocity;
@property (nonatomic) BOOL repeat;
@property (nonatomic,readonly) BOOL done;
-(id)initWithRect:(NSRect)rect andImage:(NSImage*)image ;
-(void)animate;
@end

