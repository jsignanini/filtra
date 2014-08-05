//
//  FLTRTabsCollection.m
//  Filtra
//
//  Created by José Signanini on 7/21/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRTabsCollection.h"
#import "FLTRTab.h"

@implementation FLTRTabsCollection

static NSMutableArray *tabs;
static FLTRTab *currentTab;

+ (void) initialize
{
    [super initialize];
    tabs = [[NSMutableArray alloc] init];
    
    FLTRTab *firstTab = [[FLTRTab alloc] init];
    [tabs addObject: firstTab];
    [self switchToTabAtIndex: [tabs indexOfObject: firstTab]];
}

+ (id) alloc
{
    [NSException raise:@"Cannot be instantiated!" format:@"Static class 'FLTRTabsCollection' cannot be instantiated!"];
    return nil;
}

+ (NSMutableArray *) getTabs
{
    return tabs;
}

+ (NSUInteger) getCurrentTabIndex
{
    return [tabs indexOfObject: currentTab];
}

+ (void) createTab: (NSString*) url
{
    FLTRTab *newTab = [[FLTRTab alloc] init];
    [tabs addObject: newTab];
    if (url != nil) {
        [newTab loadUrlOrSearch: url];
    }
    [self switchToTabAtIndex: newTab.iden];
}

+ (void) switchToTabAtIndex: (NSUInteger) index
{
    currentTab = [tabs objectAtIndex: index];
}







@end
