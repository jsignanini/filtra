//
//  FLTRTabsCollection.h
//  Filtra
//
//  Created by José Signanini on 7/21/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTRTab.h"

@interface FLTRTabsCollection : NSObject

+ (NSMutableArray *) getTabs;
+ (int) getCurrentTabIndex;
+ (void) createTab;

@end
