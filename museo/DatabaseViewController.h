//
//  DatabaseViewController.h
//  museo
//
//  Created by Sergio Romero on 03/06/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <AVFoundation/AVAudioPlayer.h>

@interface DatabaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    sqlite3 *db;
    int numPosicion;
    
    AVAudioPlayer *audioPlayer;
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@property (weak, nonatomic) IBOutlet UITableView *audiosTable;
@property (weak, nonatomic) IBOutlet UILabel *lblOutput;
- (IBAction)playButton:(id)sender;

//Array para guardar las lecturas que hacemos de la base de datos
@property (nonatomic,retain) NSMutableArray *entries;
@property (nonatomic,retain) NSMutableArray *ArrayNombreAudios;
@property (nonatomic,retain) NSMutableArray *ArrayDescripcionAudios;
@property (nonatomic,retain) NSMutableArray *ArrayZonaMuseos;

//Definimos las columnas de la tabla ListaAudios de la Base de datos
@property (nonatomic,readonly) NSInteger *idTabla;
@property (nonatomic,readonly) NSString *ZonaMuseo;
@property (nonatomic,readonly) NSString *NombreAudio;
@property (nonatomic,readonly) NSString *DetalleAudio;

@property (strong, nonatomic) IBOutlet UIButton *playButton;

-(void)createTable: (NSString *) tableName
        withField1:(NSString *) field1
        withField2:(NSString *) field2
        withField3:(NSString *) field3
        withField4:(NSString *) field4;


@end
