//
//  FLTRTabsViewController.m
//  Filtra
//
//  Created by José Signanini on 7/21/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import "FLTRTabsViewController.h"
#import "FLTRTabCell.h"
#import "FLTRTab.h"
#import "FLTRTabsCollection.h"

@interface FLTRTabsViewController ()

@end

@implementation FLTRTabsViewController

-(NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[FLTRTabsCollection getTabs] count] + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    long row = [indexPath row];
    FLTRTabCell *tabCell;
    FLTRTab *tab;
    
    if ([collectionView numberOfItemsInSection: 0] == row + 1) {
        tabCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"New Tab" forIndexPath:indexPath];
        
    } else {
        tab = [FLTRTabsCollection getTabs][row];
        tabCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Tab Cell" forIndexPath:indexPath];
        
        tabCell.pageTitle.text = [tab title];
        
        
        CGRect rect = [tab.webView bounds];
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0f);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [tab.webView.layer renderInContext:context];
        UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        tabCell.screenshot.image = capturedScreen;
    }
    
    return tabCell;
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newTab:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
