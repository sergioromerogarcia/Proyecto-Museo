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
    // Do any additional setup after loading the view.
    _audiosTable.delegate = self;
    _audiosTable.dataSource = self;
}

-(void) checkAndCreateDatabase{
    
    BOOL success;
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:@"ListaAudios.db"];
    
    NSLog(@"databasePath : %@", databasePath);
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    success = [fileManager fileExistsAtPath:databasePath];
    
    if(success) return;
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ListaAudios.db"];
    
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
}

-(void)readTable{
   
    //Inicializamos los arrays a cargar
    _entries = [[NSMutableArray alloc]init];
    _ArrayNombreAudios = [[NSMutableArray alloc] init];
    _ArrayDescripcionAudios = [[NSMutableArray alloc] init];
    _ArrayZonaMuseos = [[NSMutableArray alloc] init];
    
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSLog(@"documentPaths : %@", documentPaths);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"ListaAudios.db"];
	sqlite3 *database;
    
    
    if(sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK)
    {
        NSString *query = [NSString stringWithFormat:@"SELECT * FROM ListaAudios"];
        NSLog(@"QUERY : %@", query);
        const char *sqlStatementGet = [query UTF8String];
        sqlite3_stmt *compiledStatementGet;
		if(sqlite3_prepare_v2(database, sqlStatementGet, -1, &compiledStatementGet, NULL) == SQLITE_OK)
        {
			while(sqlite3_step(compiledStatementGet) == SQLITE_ROW)
            {
                //Recuperamos el valor de las columnas de cada registro
                /*
                char *field1 = (char *) sqlite3_column_text(compiledStatementGet, 0);
                NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
                 */
                char *field2 = (char *) sqlite3_column_text(compiledStatementGet, 1);
                NSString *field2Str = [[NSString alloc] initWithUTF8String:field2];
               
                char *field3 = (char *) sqlite3_column_text(compiledStatementGet, 2);
                NSString *field3Str = [[NSString alloc] initWithUTF8String:field3];
                
                char *field4 = (char *) sqlite3_column_text(compiledStatementGet, 3);
                NSString *field4Str = [[NSString alloc] initWithUTF8String:field4];
                
                NSLog(@"NombreAudio  '%@'",field3Str );
                [_ArrayNombreAudios addObject: field3Str];
                NSLog(@"DetalleAudio  '%@'",field4Str );
                [_ArrayDescripcionAudios addObject:field4Str];
                NSLog(@"ZonaMuseo '%@'", field2Str);
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

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_ArrayNombreAudios count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"MyCell";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (thisCell == nil){
        thisCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    thisCell.textLabel.text = [_ArrayNombreAudios objectAtIndex:indexPath.row];
    return thisCell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    _lblOutput.text = [_ArrayDescripcionAudios objectAtIndex:indexPath.row];
}

//Como se peude pasar el indexpath .row?
- (IBAction)playButton:(id)sender {
   /*
    AVAudioPlayer *audioPlayer;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:[_ArrayNombreAudios objectAtIndex:indexPath.row]
                                         ofType:@"mp3"]];
    audioPlayer = [[AVAudioPlayer alloc]
                   initWithContentsOfURL:url
                   error:nil];
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    */
}
@end
