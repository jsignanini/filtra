//
//  FLTRBookmarkActivity.m
//  Filtra
//
//  Created by José Signanini on 8/3/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRBookmarkActivity.h"
#import "FLTRBookmarksCollection.h"

@implementation FLTRBookmarkActivity

@synthesize url;

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"bookmark.png"];
}

- (NSString *)activityTitle
{
    return @"Bookmark";
}

- (NSString *)activityType;
{
    return @"filtra.bookmark";
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    self.url = activityItems[0];
}

- (void)performActivity
{
    [self activityDidFinish: YES];
}

@end