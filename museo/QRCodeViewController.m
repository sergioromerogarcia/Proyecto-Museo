//
//  QRCodeViewController.m
//  museo
//
//  Created by Sergio Romero on 28/05/14.
//  Copyright (c) 2014 uoc. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()
//Flag para saber si estamos escaneando un código QR
@property (nonatomic) BOOL isReading;
//Declaración de los métodos del AVFoundationFramework para poder manejar el flujo de datos de las entradas AV
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
//Declaración del método necesario para reproducir un archivo de Audio
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

//Declaración de los métodos que utilizamos para detectar si estamos realizando la captura
-(BOOL)startReading;
-(void)stopReading;
//*****************************************************************************************

-(void)loadBeepSound;
@end

@implementation QRCodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Inicializamos la variable que controla si estamos escaneando la variable
    _isReading = NO;
    //Inicializamos el método
    _captureSession = nil;
    //Cargamos el fichero de sonido
    [self loadBeepSound];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}


#pragma mark - Navigation

- (IBAction)startStopReading:(id)sender {
    if (!_isReading) {
        // Controlamos que estemos leyendo el código QR o en su defecto hayamos pulsado el botón de START
        if ([self startReading]) {
            //Si nos devuelve YES la variable cambiamos el título del botón y el mensaje de la barra de status
            [_bbitemStart setTitle:@"Stop"];
            [_lblStatus setText:@"Escaneando QR Code..."];
        }
    }
    else{
        // Nos encontramos leyendo el código o hemos pulsado el botón de Stop
        [self stopReading];
        // Cambiamos el título de del botón
        [_bbitemStart setTitle:@"Empezar!"];
    }
    
    // Reiniciamos el flag en el estado inicial
    _isReading = !_isReading;
}

- (BOOL)startReading {
    NSError *error;
    

    //Accedemos a nuestro device espcificando que queremos capturar video
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //Instanciamos el AVCaptureDeviceInput utilizando el device declarado anteriormente.
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    if (!input) {
        // Capturamos cualquier error que pueda ocurrir
        NSLog(@"%@", [error localizedDescription]);
        //Salimos de la función
        return NO;
    }
    
    // Inicializamos el objeto AVCaptureSession
    _captureSession = [[AVCaptureSession alloc] init];
    // Asignamos el Device declarado anteriormente al input
    [_captureSession addInput:input];
    
    //Un captureSession necesita de los objetos tanto de entrada como de salida
    //Inicializamo el objeto AVCaptureMetdataOutput y lo definimos como Output al capture session
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [_captureSession addOutput:captureMetadataOutput];
    
    // Según la documentación es necesario asignar a una cola en serie para asegurar que no se ejectue
    // ninguna otra tarea al mismo tiempo
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create("myQueue", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // Inicializamos el capa de Preview para mostrar al usuario que está enfocando la cámara
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:_viewPreview.layer.bounds];
    [_viewPreview.layer addSublayer:_videoPreviewLayer];
    
    
    // Iniciamos la captura
    [_captureSession startRunning];
    
    return YES;
}

//Método para interceptar la matadata capturado por el device.
// El array contiene los datos leidos por el device
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    // Comprobación del array, que no sea nulo y que contenga un elemento como mínimo
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        // Obtenemos el objeto metadata
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            // Si el metadata es el código QR leido entonces deberemos actualizar el texto del label
            // Acto seguido paramos de leer y cambiamos el estado del botón
            [_lblStatus performSelectorOnMainThread:@selector(setText:) withObject:[metadataObj stringValue] waitUntilDone:NO];
            //Lanzamos la url que nos devuelve el código QR
            [[UIApplication sharedApplication] openURL:
             [NSURL URLWithString:
              [NSString stringWithFormat:@"%@", [metadataObj stringValue]]]];
            
            [self performSelectorOnMainThread:@selector(stopReading) withObject:nil waitUntilDone:NO];
            [_bbitemStart performSelectorOnMainThread:@selector(setTitle:) withObject:@"Empezar!" waitUntilDone:NO];
            // Paramos de leer
            _isReading = NO;
            
            // Reproducimos el archivo de audio
            if (_audioPlayer) {
                [_audioPlayer play];
            }
        }
    }
    
    
}
-(void)stopReading{
    //Paramos la captura de video y ponemos el captureSession a null
    [_captureSession stopRunning];
    _captureSession = nil;
    
    // Eliminamos la capa de video
    [_videoPreviewLayer removeFromSuperlayer];
}
-(void)loadBeepSound{
    // Get the path to the beep.mp3 file and convert it to a NSURL object.
    // Obtenemos el archivo beep.mp3 y lo convertimos en un objeto NSURL que contiene la URL del directorio
    NSString *beepFilePath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"mp3"];
    NSURL *beepURL = [NSURL URLWithString:beepFilePath];
    
    NSError *error;
    
    // Incializamos el reproductor utilizando la url del directorio donde se encuentra el archivo
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:beepURL error:&error];
    if (error) {
        // Capturamos cualquier error que pueda dar la inicialización del objeto
        NSLog(@"No es posible reproducir el archivo de audio.");
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        [_audioPlayer prepareToPlay];
    }
}
@end
