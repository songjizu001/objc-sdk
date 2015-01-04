//
//  QNDns.m
//  QiniuSDK
//
//  Created by bailong on 15/1/2.
//  Copyright (c) 2015年 Qiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <arpa/inet.h>

#import "QNDns.h"

@implementation QNDns

+ (NSArray *)getAddresses:(NSString *)hostName {
	CFHostRef hostRef = CFHostCreateWithName(kCFAllocatorDefault, (__bridge CFStringRef)hostName);

	Boolean lookup = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
	NSArray *addresses = (__bridge NSArray *)CFHostGetAddressing(hostRef, &lookup);
	__block NSMutableArray *ret = [[NSMutableArray alloc] init];
	[addresses enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
	    struct in_addr *data = (__bridge struct in_addr *)obj;
	    char *p = inet_ntoa(*data);
	    NSString *ip = [NSString stringWithUTF8String:p];
	    [ret addObject:ip];
//        NSLog(@"Resolved %lu->%@", (unsigned long)idx, ip);
	}];
	return ret;
}

@end
