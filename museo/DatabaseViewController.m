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


- (void)viewDidLoad
{
    [self openDB];
    [self readTable];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _audiosTable.delegate = self;
    _audiosTable.dataSource = self;
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

//Método para la lectura de base de datos
-(void)readTable{

    //Inicializamos los arrays a cargar
    _entries = [[NSMutableArray alloc]init];
    _ArrayNombreAudios = [[NSMutableArray alloc] init];
    _ArrayDescripcionAudios = [[NSMutableArray alloc] init];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM tablaTest"];
    sqlite3_stmt *statement;
    
    
    if(sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, NULL) == SQLITE_OK){
        while (sqlite3_step(statement) == SQLITE_ROW) {
            //Recuperamos el valor de las columnas de cada registro
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *field1Str = [[NSString alloc] initWithUTF8String:field1];
            
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *field2Str = [[NSString alloc] initWithUTF8String:field2];
            
            char *field3 = (char *) sqlite3_column_text(statement, 2);
            NSString *field3Str = [[NSString alloc] initWithUTF8String:field3];
            
            char *field4 = (char *) sqlite3_column_text(statement, 3);
            NSString *field4Str = [[NSString alloc] initWithUTF8String:field4];
            
            [_ArrayNombreAudios addObject: field3Str];
            [_ArrayDescripcionAudios addObject:field4Str];
            
        }
    }
}

//Recuperamos el fichero
-(NSString *) filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent:@"test.sqlite"];
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

@end
