//
//  DatabaseViewController.m
//  museo
//
//  Created by Sergio Romero on 03/06/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import "DatabaseViewController.h"

@interface DatabaseViewController ()

@end

@implementation DatabaseViewController

-(void)createTable: (NSString *) tableName
        withField1:(NSString *) field1
        withField2:(NSString *) field2
        withField3:(NSString *) field3
        withField4:(NSString *) field4;
{
    NSLog(@"Entrando en el método createTable...");
    //Variable para controlar cualquier error
    char *err;
    //Variable para la sentencia SQL
    NSString *sql = [NSString stringWithFormat:
                     @"CREATE TABLE IF NOT EXIST '%@' ('%@' "
                     "INTEGER PRIMARY KEY, '%@' TEXT, '%@' TEXT, '%@' TEXT);",tableName,field1,field2,field3,field4];
    if(sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK){
        sqlite3_close(db);
        NSLog(@"Ya existe la tabla, no se ha creado.");
    }else{
        NSLog(@"Tabla creada correctamente");
    }
}
//Deberemos pasar como parámetro la zona donde nos encontramos
-(void)readTable{
    //Inicializamos el array
    _entries = [[NSMutableArray alloc]init];
    //Parámetro con la zona donde se encuentran
    NSString *zonamuseo;
//  NSString *sql = [NSString stringWithFormat:@"SELECT NombreAudio from ListaAudios where ZonaMuseo = '%@'",zonamuseo];
    NSString *sql = [NSString stringWithFormat:@"SELECT NombreAudio from ListaAudios"];
    sqlite3_stmt *statement;
    
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //Recuperamos el valor de la columna Audio
            char *audio = (char *) sqlite3_column_text(statement, 2);
            NSString *audioStr = [[NSString alloc] initWithUTF8String:audio];
            NSLog(@"Nombre del Audio '%@",audioStr);
        }
    }
}

//Recuperamos el fichero
-(NSString *) filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"ListaAudios.db"];
}

//Abrimos la base de datos
-(void) openDB{
    if (sqlite3_open([[self filePath] UTF8String], &(db)) != SQLITE_OK){
        sqlite3_close(db);
        NSAssert(0, @"Error al abrir la base de datos");
    }else{
        NSLog(@"Base de datos abierta");
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self openDB];
    [self readTable];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
