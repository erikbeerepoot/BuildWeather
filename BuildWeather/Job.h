#import <Foundation/Foundation.h>
#import "Build.h"

@interface Job : NSObject

@property (nonatomic, retain, readonly) Build *lastBuild;

@end
