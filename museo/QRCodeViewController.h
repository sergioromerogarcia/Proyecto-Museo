//
//  QRCodeViewController.h
//  museo
//
//  Created by Sergio Romero on 28/05/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface QRCodeViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;
//Capturamos el botón
- (IBAction)startStopReading:(id)sender;
@end
