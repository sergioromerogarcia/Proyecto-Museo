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
AVAudioPlayer *audioPlayer;

- (void)viewDidLoad
{
    [self checkAndCreateDatabase];
    [self readTable];
    [super viewDidLoad];
    _audiosTable.delegate = self;
    _audiosTable.dataSource = self;
}

//Comprobamos que exista la base de datos y en su defecto la copiamos al dispositivo
-(void) checkAndCreateDatabase{
    
    BOOL success;
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"ListaAudios.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ListaAudios.db"];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}

//Método de lectura de la base de datos.
-(void)readTable{
   
    //Inicializamos los arrays a cargar
    _ArrayNombreAudios = [[NSMutableArray alloc] init];
    _ArrayDescripcionAudios = [[NSMutableArray alloc] init];
    _ArrayZonaMuseos = [[NSMutableArray alloc] init];
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"ListaAudios.db"];
	sqlite3 *database;
    
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM ListaAudios"];
        const char *sqlStatementGet = [query UTF8String];
        sqlite3_stmt *compiledStatementGet;
		if(sqlite3_prepare_v2(database, sqlStatementGet, -1, &compiledStatementGet, NULL) == SQLITE_OK)
        {
			while(sqlite3_step(compiledStatementGet) == SQLITE_ROW)
            {
                //Recuperamos el valor de las columnas de cada registro
                
                char *field2 = (char *) sqlite3_column_text(compiledStatementGet, 1);
                NSString *field2Str = [[NSString alloc] initWithUTF8String:field2];
               
                char *field3 = (char *) sqlite3_column_text(compiledStatementGet, 2);
                NSString *field3Str = [[NSString alloc] initWithUTF8String:field3];
                
                char *field4 = (char *) sqlite3_column_text(compiledStatementGet, 3);
                NSString *field4Str = [[NSString alloc] initWithUTF8String:field4];
                
                [_ArrayNombreAudios addObject: field3Str];
    
                [_ArrayDescripcionAudios addObject:field4Str];
    
                [_ArrayZonaMuseos addObject:field2Str];

            }
        }
    }
    
}

//Método para crear la tabla en el caso que no exista
-(void)createTable: (NSString *) tableName
        withField1:(NSString *) field1
        withField2:(NSString *) field2
        withField3:(NSString *) field3
        withField4:(NSString *) field4;
{
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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Secciones de la TableView
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//Número de filas de la tabla, tantas como elementos del array
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ArrayNombreAudios count];
}

//Cargamos el nombre del audio en cada fila
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"MyCell";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (thisCell == nil){
        thisCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    thisCell.textLabel.text = [_ArrayNombreAudios objectAtIndex:indexPath.row];
    return thisCell;
}

//Cargamos el detalle del audio en el label según la fila seleccionada
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    numPosicion = indexPath.row;
    _lblOutput.text = [_ArrayDescripcionAudios objectAtIndex:(indexPath.row)];
}

//Lanzamos el play del audio seleccionado controlando el texto del label si se está reproduciendo o no el audio.
- (IBAction)playButton:(id)sender {
   
    if ([audioPlayer isPlaying])
    {
        [audioPlayer stop];
        [audioPlayer setCurrentTime:0.0];
        [self.playButton setTitle:@"Play" forState:normal];
    }
    else
    {
        //Recuperamos el valor del nombre del audio de la base de datos
        NSString *filename = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[_ArrayNombreAudios objectAtIndex:numPosicion]] ofType:@"mp3"];

        NSURL *url = [NSURL URLWithString:filename];

        audioPlayer = [[AVAudioPlayer alloc]
                       initWithContentsOfURL:url
                       error:nil];
        [audioPlayer prepareToPlay];
        [audioPlayer play];
        [self.playButton setTitle:@"Stop" forState:normal];
    }
}
@end
