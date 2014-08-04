//
//  FLTRBookmarksCollection.m
//  Filtra
//
//  Created by José Signanini on 7/30/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRBookmarksCollection.h"
#import "FLTRBookmark.h"

@implementation FLTRBookmarksCollection

static NSMutableArray *bookmarks;

+ (void) initialize
{
    [super initialize];
    bookmarks = [[NSMutableArray alloc] init];
//    [self switchToTabAtIndex: [tabs indexOfObject: firstTab]];
}

+ (id) alloc
{
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'FLTRTabsCollection' cannot be instantiated!"];
    return nil;
}

+ (NSMutableArray *) getBookmarks
{
    return bookmarks;
}

+ (void) addBookmarkWithUrl:(NSString *)url title:(NSString *)title
{
    FLTRBookmark *bookmark = [[FLTRBookmark alloc] init];
    bookmark.url = [NSURL URLWithString:url];
    bookmark.title = title;
    bookmark.favicon = [UIImage imageWithData: [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [url stringByAppendingString:@"/favicon.ico"]]]];
    [bookmarks addObject: bookmark];
}

+ (void) deleteBookmark:(int)index
{
    [bookmarks removeObjectAtIndex:index];
}



@end
