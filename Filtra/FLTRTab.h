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
@property int iden;
@property UIImage *screenshot;

- (void)loadUrlOrSearch: (NSString*) text;

//- (NSString*) getTitle;

@end
