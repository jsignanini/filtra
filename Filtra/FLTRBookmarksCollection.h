//
//  FLTRBookmarksCollection.h
//  Filtra
//
//  Created by José Signanini on 7/30/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTRBookmarksCollection : NSObject

+ (NSMutableArray *) getBookmarks;
+ (void) addBookmarkWithUrl: (NSString*)url title: (NSString*)title;
+ (void) deleteBookmark: (int) index;

@end
