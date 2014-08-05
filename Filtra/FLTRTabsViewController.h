//
//  FLTRTabsViewController.h
//  Filtra
//
//  Created by José Signanini on 7/21/14.
//  Copyright (c) 2014 José María Signanini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLTRTabsViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property int currentTabIndex;
- (IBAction)clickNewTab:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end
