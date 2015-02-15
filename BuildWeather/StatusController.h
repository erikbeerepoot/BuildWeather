#import <Foundation/Foundation.h>

@class Job;
@interface StatusController : NSObject
@property (nonatomic, retain, readonly) NSMutableArray *jobs;
@end
