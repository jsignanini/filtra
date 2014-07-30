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

@synthesize title, url, webView, iden, screenshot, framesToLoad, framesLoaded, currentProgress, monitorProgress, completeIfError;

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
    [self resetForNewPage];
    
    return self;
}

/*** UIWebViewDelegate Protocol ***/
- (void)resetProgress {
    framesToLoad = 0;
    framesLoaded = 0;
    currentProgress = 0.0f;
}

- (void)resetForNewPage {
    // Reset progress
    [self resetProgress];
    
    // Monitor the page load
    monitorProgress = YES;
    
    // Keep going if errors occur
    // completeIfError = NO;
    
    // Stop updates if an error occurs
    completeIfError = YES;
}

- (void)webViewLoaded {
    [self resetProgress];
    //    [entryProgressView setProgress: 0.0f animated: YES];
    [self setTitle: [self.webView stringByEvaluatingJavaScriptFromString: @"document.title"]];
    [self updateScreenshot];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
    //        // Reset state for new page load
    //        [self resetForNewPage];
    //    }
    
    
    BOOL isFrame = ![[[request URL] absoluteString] isEqualToString:[[request mainDocumentURL] absoluteString]];
    
    if (isFrame) {
    } else {
        [self resetForNewPage];
    }
    
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (!monitorProgress) {
        return;
    }
    
    // Increment frames to load counter
    framesToLoad++;
}

-(void)webViewDidFinishLoad:(UIWebView *) aWebView {
    if (!monitorProgress) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return;
    }
    
    // Increment frames loaded counter
    framesLoaded++;
    
    // Update progress display
    float newProgress = ((float) framesLoaded) / framesToLoad;
    if (newProgress > currentProgress) {
        currentProgress = newProgress;
        //        [entryProgressView setProgress: newProgress animated: YES];
    }
    
    // Finish progress updates if loading is complete
    if (!aWebView.loading) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        monitorProgress = NO;
        
        //        [entryProgressView setProgress: 1.0 animated: YES];
        [self performSelector:@selector(webViewLoaded) withObject: nil afterDelay: 1.0];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (!monitorProgress) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return;
    }
    
    // Increment frames loaded counter
    framesLoaded++;
    
    // Update progress display
    float newProgress = ((float) framesLoaded) / framesToLoad;
    if (newProgress > currentProgress) {
        currentProgress = newProgress;
        //        [entryProgressView setProgress: newProgress animated: YES];
    }
    
    // Finish progress updates if required
    if (completeIfError) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        monitorProgress = NO;
        
        //        [entryProgressView setProgress: 1.0 animated: YES];
        [self performSelector:@selector(webViewLoaded) withObject: nil afterDelay: 1.0];
    }
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
