//
//  DatabaseViewController.h
//  museo
//
//  Created by Sergio Romero on 03/06/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface DatabaseViewController : UIViewController
{
    sqlite3 *db;
}
//Array para guardar las lecturas que hacemos de la base de datos
@property (nonatomic,retain) NSMutableArray *entries;
//Definimos las columnas de la tabla ListaAudios de la Base de datos
@property (nonatomic,readonly) NSInteger *idTabla;
@property (nonatomic,readonly) NSString *ZonaMuseo;
@property (nonatomic,readonly) NSString *NombreAudio;
@property (nonatomic,readonly) NSString *DetalleAudio;
//Path de la base de datos
- (NSString *) filePath;
-(void)openDB;

-(void)createTable: (NSString *) tableName
        withField1:(NSString *) field1
        withField2:(NSString *) field2
        withField3:(NSString *) field3
        withField4:(NSString *) field4;
-(void)readTable;
@end
