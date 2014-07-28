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
    
    self.iden = [[FLTRTabsCollection getTabs] count];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"newtab" ofType:@"html"];
    NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
    self.title = @"about:tab";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(webViewFinalLoad:) name:@"WebViewProgressFinishedNotification" object:self.webView];
    
    return self;
}

/*** UIWebViewDelegate Protocol ***/

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL isFrame = ![[[request URL] absoluteString] isEqualToString:[[request mainDocumentURL] absoluteString]];
    
    if (isFrame) {
        //        NSLog(@"Frame: %@", request.URL.absoluteString);
        
    } else {
        //        NSLog(@"Loading: %@", request.URL.absoluteString);
        
        NSString *urlLoading = request.URL.absoluteString;
        if ([urlLoading length] > 0) {
//            [self updateAddressBar: urlLoading];
        }
    }
    
    //    return ! self.pageLoaded;
//    reloadStopButton.selected = YES;
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    self.pageLoaded = YES;
//    reloadStopButton.selected = NO;
//    [self updateBackForwardButtons: theWebView];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    [self updateScreenshot];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
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

- (void)webViewFinalLoad:(id)sender
{
    NSLog(@"NOTIFIED!");
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
