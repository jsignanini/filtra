//
//  FLTRRequestListener.m
//  Filtra
//
//  Created by José Signanini on 5/10/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRRequestListener.h"

@implementation FLTRRequestListener

- (NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest*)request
{
    //    NSURL *url = [request URL];
    //    BOOL blockURL = [[FilterMgr sharedFilterMgr] shouldBlockURL:url];
    //    if (blockURL) {
    //        NSURLResponse *response =
    //        [[NSURLResponse alloc] initWithURL:url
    //                                  MIMEType:@"text/plain"
    //                     expectedContentLength:1
    //                          textEncodingName:nil];
    //
    //        NSCachedURLResponse *cachedResponse =
    //        [[NSCachedURLResponse alloc] initWithResponse:response
    //                                                 data:[NSData dataWithBytes:" " length:1]];
    //
    //        [super storeCachedResponse:cachedResponse forRequest:request];
    //
    //    }
//    NSLog(@"Request: %@", request.URL.absoluteString);
    return [super cachedResponseForRequest:request];
}

@end
