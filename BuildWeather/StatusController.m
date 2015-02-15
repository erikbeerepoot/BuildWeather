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
 * @name: StatusController.m
 * @author: Erik E. Beerepoot
 * @company: Barefoot Inc.
 * @brief: Class that interacts with the Jenkins API to pull down the build status.
 */
#import "StatusController.h"
#import "constants.h"
#import "Job.h"

@implementation StatusController

-(id)init {
    if(self = [super init]){
        //setup timer
    }
    return self;
}

/**
 * @name: parseJobList
 * @brief: Parses the list of jobs from JSON into an array
 */
-(void)parseJobList:(NSData*)jobData {
    
}

/**
 * @name:  queryJobStatusForJob
 * @brief: Queries jenkins for the status of a job
 * @param: job
 */
-(void)queryJobStatusForJob:(Job*)job {
    //1. Create new URL session
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate:nil delegateQueue: [NSOperationQueue mainQueue]];
    
    //2. Create query URL
    NSString *jobStatusEndpoint = [kJenkinsServerURL stringByAppendingString:[job.name stringByAppendingString:kLastBuildEndpoint]];
    
    //3. Send job status request
    [[delegateFreeSession dataTaskWithURL:[NSURL URLWithString:jobStatusEndpoint] completionHandler:^(NSData *data,
                                                                                                      NSURLResponse *response,
                                                                                                      NSError *error) {
        //call the processing method using GCD
        dispatch_async(dispatch_get_main_queue(),^{
            [self statusCallbackWithData:data response:response andError:error];
        });
        
    }] resume];
    
}

-(void)statusCallbackWithData:(NSData*)data response:(NSURLResponse*)response andError:(NSError*)error {
  
}


@end
