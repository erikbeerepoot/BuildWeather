#ifndef __CONSTANTS_H_
#define __CONSTANTS_H_

//
//  constants.h
//  BuildWeather
//
//  Created by Erik E. Beerepoot on 2015-02-14.
//  Copyright (c) 2015 Mediacore Technologies Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//connection parameters
const int portnum = 8088;
const NSString *kJenkinsServerURL = @"192.168.1.10";

//API endpoints
const NSString *kLastBuildEndpoint = @"/lastBuild/api/json";
const NSString *kListJobsEndpoint = @"/api/xml?tree=jobs[name]";

#endif