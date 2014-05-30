//
//  ViewController.h
//  museo
//
//  Created by Sergio Romero on 02/05/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *imagenesMuseo, *imagenesLabel;
}
@end
