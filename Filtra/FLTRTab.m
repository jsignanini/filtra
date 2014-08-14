//
//  FLTRTab.m
//  Filtra
//
//  Created by José Signanini on 7/21/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRTab.h"
#import "FLTRTabsCollection.h"

@implementation FLTRTab

@synthesize title, url, webView, iden, screenshot;

- (id) init
{
    self.webView = [[UIWebView alloc] initWithFrame: CGRectMake(0, 0, 320, 464)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.hidden = YES;
    [self.webView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth)];
    
    self.iden = [[FLTRTabsCollection getTabs] count];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"newtab" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    
    return self;
}

/*** UIWebViewDelegate Protocol ***/
- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL isFrame = ![[[request URL] absoluteString] isEqualToString:[[request mainDocumentURL] absoluteString]];
    
    if (isFrame) {
        if ([[[request URL] scheme] isEqualToString: @"fltr"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"webViewFinishedLoad" object:self userInfo:nil];
            return NO;
        }
        
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"webViewStartedLoad" object:self userInfo:nil];
    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)aWebView
{
}

-(void)webViewDidFinishLoad:(UIWebView *) aWebView
{
    [aWebView stringByEvaluatingJavaScriptFromString:
                      @"if (!window.FLTR) {"
                            "function pageLoaded() {"
                                "var s = document.createElement('iframe');"
                                "s.setAttribute('src', 'fltr://pageLoaded');"
                                "s.setAttribute('width', '1px');"
                                "s.setAttribute('height', '1px');"
                                "document.body.appendChild(s);"
                                "document.body.removeChild(s);"
                            "}"

                            "if (document.readyState != 'complete') {"
                                "window.addEventListener('load', pageLoaded, true);"
                            "} else {"
                                "pageLoaded();"
                            "}"
                            "window.FLTR = true;"
                        "}"
                  ];
    
//    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
//    [userInfo setObject:[NSNumber numberWithFloat: 0.0f] forKey: @"progress"];
//    [userInfo setObject:[NSNumber numberWithBool: NO] forKey: @"animated"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"webViewProgress" object:self userInfo:nil];
    [self updateScreenshot];
    self.title = [aWebView stringByEvaluatingJavaScriptFromString: @"document.title"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

- (BOOL)validateUrl:(NSString *)candidate {
    if ([candidate rangeOfString:@" "].location != NSNotFound ||
        [candidate rangeOfString:@"."].location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (void)loadUrlOrSearch:(NSString *)text
{
    if ([self validateUrl:text]) {
        if ([text rangeOfString:@"://"].location == NSNotFound) {
            text = [@"http://" stringByAppendingString: text];
        }
        NSURLRequest *requestURL = [NSURLRequest requestWithURL:[NSURL URLWithString:text]];
        [self.webView loadRequest:requestURL];
    } else {
        // TODO Do DuckDuckGo search
        //        [self updateAddressBar: [NSString stringWithFormat:@"http://www.google.com/search?q=%@", text]];
        
        
        //        NSString *unescaped = @"http://www";
        NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]\" ";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        NSString *encodedString = [text stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
        
        
        NSURLRequest *requestURL = [NSURLRequest requestWithURL:
                                    [NSURL URLWithString: [NSString stringWithFormat:@"http://www.google.com/search?q=%@", encodedString]]];
        
        [self.webView loadRequest:requestURL];
    }
    
}

- (void) updateScreenshot
{
    CGRect rect = [self.webView bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.webView.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.screenshot = capturedScreen;
}

@end
