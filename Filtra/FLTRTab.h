//
//  FLTRTab.h
//  Filtra
//
//  Created by José Signanini on 7/21/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLTRTab : NSObject <UIWebViewDelegate>

//+(UIWebView*) webView;

@property UIWebView *webView;
@property NSString *url;
@property NSString *title;
@property NSUInteger iden;
@property UIImage *screenshot;

@property int framesToLoad;
@property int framesLoaded;
@property float currentProgress;
@property BOOL monitorProgress;
@property BOOL completeIfError;

- (void) loadUrlOrSearch: (NSString*) text;

//- (NSString*) getTitle;

@end
