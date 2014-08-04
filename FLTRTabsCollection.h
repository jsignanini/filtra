//
//  FLTRTabsCollection.h
//  Filtra
//
//  Created by José Signanini on 7/21/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTRTabsCollection : NSObject

+ (NSMutableArray *) getTabs;
+ (void) switchToTabAtIndex: (NSUInteger) index;
+ (NSUInteger) getCurrentTabIndex;
+ (void) createTab: (NSString*) url;

@end
