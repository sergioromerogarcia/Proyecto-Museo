//
//  ScrollViewController.m
//  museo
//
//  Created by Sergio Romero on 20/05/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void) loadInformationinScroll{
    
    UIImageView *image = [ [UIImageView alloc] initWithImage:[UIImage imageNamed:@"planta-baixa2.gif"]];
    image.frame = CGRectMake(0, 0, 416, 740);
    [self.scroll addSubview:image];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(65, 80, 10, 10);

    [button1 addTarget:self action:@selector(info1:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundImage:[UIImage imageNamed:@"medical.png"]forState:UIControlStateNormal];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(255, 150, 12, 12);
    
    [button2 addTarget:self action:@selector(info2:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setBackgroundImage:[UIImage imageNamed:@"Restaurant.png"]forState:UIControlStateNormal];

    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(355, 270, 12, 12);
    
    [button3 addTarget:self action:@selector(info3:) forControlEvents:UIControlEventTouchUpInside];
    [button3 setBackgroundImage:[UIImage imageNamed:@"llave.png"]forState:UIControlStateNormal];

    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectMake(250, 355, 12, 12);
    
    [button4 addTarget:self action:@selector(info4:) forControlEvents:UIControlEventTouchUpInside];
    [button4 setBackgroundImage:[UIImage imageNamed:@"Regalo.png"]forState:UIControlStateNormal];

    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectMake(100, 540, 12, 12);
    
    [button5 addTarget:self action:@selector(info5:) forControlEvents:UIControlEventTouchUpInside];
    [button5 setBackgroundImage:[UIImage imageNamed:@"cafeteria.png"]forState:UIControlStateNormal];

    
    [self.scroll addSubview:button1];
    [self.scroll addSubview:button2];
    [self.scroll addSubview:button3];
    [self.scroll addSubview:button4];
    [self.scroll addSubview:button5];
    
    [self.scroll setContentSize:(CGSizeMake(590, 750))];
}

- (IBAction)info1:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enfermería" message:@"Abierta durante el horario de apertura del museo." delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
    
}

- (IBAction)info2:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Restaurante" message:@"Horario de cocina de 12:30 - 15:30" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
    
}

- (IBAction)info3:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Guardarropa" message:@"Abierta durante el horario de apertura del museo." delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
    
}

- (IBAction)info4:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Boutique de Regalos" message:@"Abierta durante el horario de apertura del museo." delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
    
}

- (IBAction)info5:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cafetería" message:@"Snacks y refrescos disponible durante el horario de apertura del museo." delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles: nil];
    [alert show];
    
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
    [super viewDidLoad];
    [self loadInformationinScroll];
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
