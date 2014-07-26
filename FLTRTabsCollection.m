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

+ (void) initialize
{
    [super initialize];

    tabs = [[NSMutableArray alloc] init];
    
    FLTRTab *firstTab = [[FLTRTab alloc] init];
    FLTRTab *firstTab2 = [[FLTRTab alloc] init];
    [tabs addObject: firstTab];
    [tabs addObject: firstTab2];

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

+ (void) createTab
{
    [tabs addObject: [[FLTRTab alloc] init]];
}







@end
