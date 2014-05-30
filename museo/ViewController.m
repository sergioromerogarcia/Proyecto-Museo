//
//  ViewController.m
//  museo
//
//  Created by Sergio Romero on 02/05/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomCell.h"
#import "CuadroViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    imagenesMuseo = [ [NSArray alloc] initWithObjects:@"Arlequin.jpg",@"AzoteasBarcelona.jpg",@"BarracaMontmatre.jpg",@"BednedettaBianco.jpg",@"BlanquitaSuarez.jpg",@"Bodegon.jpg",@"CaballoCorneado.jpeg",@"CienciaCaridad.jpeg",@"Desamparados.jpg",@"Abrazo.jpg",@"Divan.jpg",@"FinalNumero.jpg",@"PaseoColon.jpg",@"HombreBoina.jpg",@"ComidaFrugal.jpg",@"MujerCofia.jpg" ,@"Ofrenda.jpg",@"TiaPepa.jpg",@"Pichones.jpg",@"Menina.jpg",@"Meninas.jpg",@"Minotauromaquia.jpg",@"PaisajeMontañoso.jpg",@"Picasso.jpg",@"PintorTrabajando.jpg", @"PoetaDecadente.jpg",@"RamonCasas.jpg",@"MadreArtista.jpg", @"PadreArtista.jpg",@"RieraSantJoan.jpg", nil ];
    
    imagenesLabel = [ [NSArray alloc]  initWithObjects:@"Arlequin", @"Azoteas Barceloba",@"Barraca Montmatre",@"Bednedetta Bianco", @"Blanquita Suarez", @"Bodegon", @"Caballo Corneado", @"Ciencia Caridad",@"Desamparados",@"Abrazo",@"Divan",@"Final Numero", @"Paseo Colon", @"Hombre Boina", @"Comida Frugal", @"Mujer Cofia", @"Ofrenda",@"Tia Pepa", @"Pichones", @"Menina",@"Meninas",@"Minotauromaquia",@"Paisaje Montañoso", @"Picasso",@"Pintor Trabajando",@"Poeta Decadente",@"Ramon Casas",@"Madre Artista", @"Padre Artista",@"Riera Sant Joan", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [imagenesMuseo count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"CellID";
    MyCustomCell *myCell = (MyCustomCell *) [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    myCell.ImagesInCell.image = [UIImage imageNamed:[imagenesMuseo objectAtIndex:indexPath.item]];
    myCell.LabelInCell.text = [imagenesLabel objectAtIndex:indexPath.item];
    return myCell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPhotoImage"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        CuadroViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        //NSLog(@"row : %ld", (long)indexPath.row);
        
        destViewController.cuadroImageName = [imagenesMuseo objectAtIndex:indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
