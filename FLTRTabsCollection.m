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

+ (int) getCurrentTabIndex
{
    return [tabs indexOfObject: currentTab];
}

+ (void) createTab
{
    FLTRTab *newTab = [[FLTRTab alloc] init];
    [tabs addObject: newTab];
    currentTab = newTab;
    [self switchToTabAtIndex: newTab.iden];
}

+ (void) switchToTabAtIndex: (int) index
{
    currentTab = [tabs objectAtIndex: index];
}







@end
