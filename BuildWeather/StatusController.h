#import <Foundation/Foundation.h>

@class Job;
@interface StatusController : NSObject
@property (nonatomic, retain, readonly) NSMutableArray *jobs;
-(void)statusCallbackWithData:(NSData*)data response:(NSURLResponse*)response andError:(NSError*)error;
@end
