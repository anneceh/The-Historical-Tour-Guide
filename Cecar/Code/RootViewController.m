//
//  RootViewController.m
//  MobileAR
//
//  Created by Alessandro Boron on 6/17/11.
//
//  Modified by Cecilie Haugstvedt
//  Copyright (c) 2012 NTNU.  
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//  http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
#import "RootViewController.h"
#import "ARController.h"
#import "InfoViewController.h"
#import "ListViewController.h"
#import "MapViewController.h"
#import "TimelineViewController.h"
#import "Photo.h"
#import "Store.h"
#import "ARGeoCoordinate.h"

@implementation RootViewController

@synthesize arController;
@synthesize infoViewController;
@synthesize listViewController;
@synthesize timelineViewController;
@synthesize mapViewController;

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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    //Initialize the ARController
    self.arController = [[ARController alloc] initWithViewController:self];
    
    //Initialize the Timeline View Controller
    TimelineViewController *tvc = [[TimelineViewController alloc] init];
    tvc.arController = self.arController;
    self.timelineViewController = tvc;
    //Add the subview to the pickercontroller view (Instead of adding it to the overlayview because of "TAP-TO-FOCUS" problem)
    [self.arController.cameraController.view addSubview:timelineViewController.view];
    
    //Initialize the info view controller
    InfoViewController *ivc = [[InfoViewController alloc] init];
    ivc.arController = self.arController;
    self.infoViewController = ivc;
    //Add view to imagePickerController.view directly to avoid "tap-to-focus" problem (blue rectangle and problem registering taps)
    [self.arController.cameraController.view addSubview:infoViewController.view];
    
    //Initialize the list view controller
    ListViewController *lvc = [[ListViewController alloc] init];
    lvc.arController = self.arController;
    self.listViewController = lvc;
    //Add view to imagePickerController.view directly to avoid "tap-to-focus" problem (blue rectangle and problem registering taps)
    [self.arController.cameraController.view addSubview:listViewController.view];
    
    //Initialize the Map View Controller
    MapViewController *navc = [[MapViewController alloc] init];
    navc.arController = self.arController;
    self.mapViewController = navc;
    //Add view to imagePickerController.view directly to avoid "tap-to-focus" problem (blue rectangle and problem registering taps)
    [self.arController.cameraController.view addSubview:mapViewController.view];
    
    [self addData];
}


//When the view appears, present the camera feed
- (void)viewDidAppear:(BOOL)animated { 
    [super viewDidAppear:animated]; 
    [arController presentCameraAnimated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)addData{
    
    CLLocation *l1 = [[CLLocation alloc] initWithLatitude:63.43185833864512 longitude:10.397626161575317];
    
    //Dronningens gate 7
    Photo *photo1 = [[Photo alloc] initPhotoWithTitle:@"Bennetgården, 1937" type:InfoTypePhoto description:@"Bildet viser syd-østre hjørne av Dronningens gate og Nordre gate. På hjørnet holdt gullsmed Eivind Christiansen til, med adresse Dronningens gate 7. Bak bilene som står parkert ser vi litt av Britannia hotell." location:l1 year:(NSInteger)1937 imagePath:@"/RR-I-00043.jpg"];
    
    ARGeoCoordinate *c1 = [[ARGeoCoordinate alloc] initWithCoordinate:l1 andInfo:photo1];
    [self.arController addCoordinate:c1 animated:NO];
    
    // Dronningens gate 7
    CLLocation *l2 = [[CLLocation alloc] initWithLatitude:63.43185833864512 longitude:10.397626161575317];
    Photo *photo2 = [[Photo alloc] initPhotoWithTitle:@"Østbyens musikkkorps, 17.mai 1958" type:InfoTypePhoto description:@"Bildet viser Østbyen musikkorps i borgertorget på Nordre, 17 mai 1958. \n \nBildet er tatt av fotograf Klaus Forbregd og donert av Grete Forbregd." location:l2 year:(NSInteger)1958 imagePath:@"/FB-58-048-A1-02.jpg" ];
    
    ARGeoCoordinate *c2 = [[ARGeoCoordinate alloc] initWithCoordinate:l2 andInfo:photo2]; 
    [self.arController addCoordinate:c2 animated:NO];
    
    
    CLLocation *l3 = [[CLLocation alloc] initWithLatitude:63.431944713296076 longitude:10.397508144378662];
    Photo *photo3 = [[Photo alloc] initPhotoWithTitle:@"Møllergården, 1906" type:InfoTypePhoto description:@"Bildet viser Møllergården i Nordre gate 12. Gården ble senere kalt Gjensidigegården og ble revet i 1954. \n \nBildet er tatt av Peter Alstrup og donert av vaktmester Kolstad." location:l3 year:(NSInteger)1906 imagePath:@"/UBT-TO-004716.jpg" ];
    
    
    ARGeoCoordinate *c3 = [[ARGeoCoordinate alloc] initWithCoordinate:l3 andInfo:photo3]; 
    [self.arController addCoordinate:c3 animated:NO];
    
    CLLocation *l4 = [[CLLocation alloc] initWithLatitude:63.43238138115665 longitude:10.397497415542603];
    Photo *photo4 = [[Photo alloc] initPhotoWithTitle:@"Nordre gate, ca 1935" type:InfoTypePhoto description:@"Bildet viser Nordre gate. På gatas venstre side, langt nede, ruver den nye Lysholmgården. På høyre side av gata, vises Dagspostens roterende lysavis over taket på Nordre gate 11. \n \nBildet er donert av Mittet & Co postkortforlag." location:l4 year:(NSInteger)1935  imagePath:@"/0613.jpg" ];
    
    ARGeoCoordinate *c4 = [[ARGeoCoordinate alloc] initWithCoordinate:l4 andInfo:photo4];
    [self.arController addCoordinate:c4 animated:NO];
    
    CLLocation *l5 = [[CLLocation alloc] initWithLatitude:63.43314913268621 longitude:10.39729356765747];
    Photo *photo5 = [[Photo alloc] initPhotoWithTitle:@"Lilleby skoles musikkorps, juni 1960" type:InfoTypePhoto description:@"Bildet viser Lilleby skoles musikkorps, juni 1960. \n \nBildet er tatt av fotograf Klaus Forbregd og donert av Grete Forbregd." location:l5 year:(NSInteger)1960  imagePath:@"/FB-60-41-D1-04.jpg"];
    
    ARGeoCoordinate *c5 = [[ARGeoCoordinate alloc] initWithCoordinate:l5 andInfo:photo5];
    [self.arController addCoordinate:c5 animated:NO];
    
    CLLocation *l6 = [[CLLocation alloc] initWithLatitude:63.430793029873705 longitude:10.397711992263794];
    Photo *photo6 = [[Photo alloc] initPhotoWithTitle:@"Vinterbilde, 1907" type:InfoTypePhoto description:@"Bildet viser to barn på ski i søndre del av Nordre gate. I bakgrunnen ser vi Vår Frue kirke. \n \nBildet er donert av Tormod Johnsen." location:l6 year:(NSInteger)1907 imagePath:@"/UBT-TO-072125.jpg"];
    
    ARGeoCoordinate *c6 = [[ARGeoCoordinate alloc] initWithCoordinate:l6 andInfo:photo6];
    [self.arController addCoordinate:c6 animated:NO];
    
    // Optikk
    CLLocation *l7 = [[CLLocation alloc] initWithLatitude:63.43066826139047 longitude:10.397733449935913];
    Photo *photo7 = [[Photo alloc] initPhotoWithTitle:@"Vinterbilde, 1915" type:InfoTypePhoto description:@"Bildet viser øverste del av Nordre gate og Vår Frue kirke. \n \nKortet er donert av Mittet & Co postkortforlag." location:l7 year:(NSInteger)1915 imagePath:@"/UBT-TO-004722.jpg"];
    
    ARGeoCoordinate *c7 = [[ARGeoCoordinate alloc] initWithCoordinate:l7 andInfo:photo7];
    [self.arController addCoordinate:c7 animated:NO];
    
    CLLocation *l8 = [[CLLocation alloc] initWithLatitude:63.43172877618051 longitude:10.397583246231079];
    Photo *photo8 = [[Photo alloc] initPhotoWithTitle:@"Julestemning i Nordre gate, 1959" type:InfoTypePhoto description:@"Bildet er tatt i Nordre gate sett sørover. I bakgrunnen skimtes såvidt Vår Frue kirke med klokken i tårnet. \n \nBildet er tatt av fotograf Klaus Forbregd og donert av Grete Forbregd. " location:l8 year:(NSInteger)1959 imagePath:@"/FB-59-101-D2-03.jpg" ];
    
    ARGeoCoordinate *c8 = [[ARGeoCoordinate alloc] initWithCoordinate:l8 andInfo:photo8];
    [self.arController addCoordinate:c8 animated:NO];
    
    CLLocation *l9 = [[CLLocation alloc] initWithLatitude:63.43336985744328 longitude:10.397282838821411];
    Photo *photo9 = [[Photo alloc] initPhotoWithTitle:@"Nordre gate, 1878" type:InfoTypePhoto description:@"Bilde viser Nordre gate sørover opp mot Vår Frue Kirke. Nederst til venstre ser vi Hotel D' Angleterre i Nordre gate 19. Første kryssende gate er Olav Trygvasons gate, og på høyre side har vi H. Matzow sin forretning. \n \nBildet er tatt av Hans Krum." location:l9 year:(NSInteger)1878  imagePath:@"/UBT-TO-001044.jpg" ];
    
    ARGeoCoordinate *c9 = [[ARGeoCoordinate alloc] initWithCoordinate:l9 andInfo:photo9];
    [self.arController addCoordinate:c9 animated:NO];
    
    CLLocation *l10 = [[CLLocation alloc] initWithLatitude:63.43332187394508 longitude:10.397282838821411];
    Photo *photo10 = [[Photo alloc] initPhotoWithTitle:@"Nordre gate, 1906" type:InfoTypePhoto description:@"Bildet viser Nordre gate sett fra Olav Tryggvasons gate opp mot Vår Frue kirke." location:l10 year:(NSInteger)1906 imagePath:@"/UBT-TO-004717.jpg" ];
    
    ARGeoCoordinate *c10 = [[ARGeoCoordinate alloc] initWithCoordinate:l10 andInfo:photo10];
    [self.arController addCoordinate:c10 animated:NO];
    
    CLLocation *l11 = [[CLLocation alloc] initWithLatitude:63.43320191484801 longitude:10.39731502532959];
    Photo *photo11 = [[Photo alloc] initPhotoWithTitle:@"Nordre gate, 1920" type:InfoTypePhoto description:@"Bildet viser Nordre gate sett fra Olav Tryggvasons gate. I bakgrunnen ser vi Vår Frue Kirkes tårn.  Huset med tårn, til venstre, er hjørnegård mot Thomas Angells gate. Lysavisa i tårnet var tidens tegn. \n \nBildet er donert av Mittet & Co postkortforlag." location:l11 year:(NSInteger)1920 imagePath:@"/0500.jpg" ];
    
    ARGeoCoordinate *c11 = [[ARGeoCoordinate alloc] initWithCoordinate:l11 andInfo:photo11];
    [self.arController addCoordinate:c11 animated:NO];
    
    CLLocation *l12 = [[CLLocation alloc] initWithLatitude:63.43035633780547 longitude:10.397679805755615];
    Photo *photo12 = [[Photo alloc] initPhotoWithTitle:@"Telegrafgården/Børsen, 1935" type:InfoTypePhoto description:@"Telegrafgården i Kongens gate ble oppført 1859-63. Børsen flyttet herfra i 1902, men navnet på gården levde videre blant folk. I 1908 ble Telegrafverket eier av bygningen. Bilen som kommer kjørende er en Buick 1925/26-modell. Vi ser skiltet til F. Bruns Bokhandel over døra helt til venstre. I en nisje i veggen til Telegrafgården står statuen av Merkur." location:l12 year:(NSInteger)1935  imagePath:@"/RR-I-00038.jpg" ];
    
    ARGeoCoordinate *c12 = [[ARGeoCoordinate alloc] initWithCoordinate:l12 andInfo:photo12];
    [self.arController addCoordinate:c12 animated:NO];
    
    CLLocation *l13 = [[CLLocation alloc] initWithLatitude:63.43272207343702 longitude:10.397454500198364];
    Photo *photo13 = [[Photo alloc] initPhotoWithTitle:@"Nordre gate, før 1900" type:InfoTypePhoto description:@"Bildet viser Nordre gate fra krysset med Thomas Angells gate og sørover. Vår Frues kirke på toppen av gaten. I hjørnegården til venstre på bildet ser vi butikkvinduene til Christian Schreiner og Harald Hirsch." location:l13 year:(NSInteger)1900  imagePath:@"/UBT-TO-002705.jpg" ];
    
    ARGeoCoordinate *c13 = [[ARGeoCoordinate alloc] initWithCoordinate:l13 andInfo:photo13];
    [self.arController addCoordinate:c13 animated:NO];
    
    CLLocation *l14 = [[CLLocation alloc] initWithLatitude:63.43038513089402 longitude:10.397765636444092];
    Photo *photo14 = [[Photo alloc] initPhotoWithTitle:@"Øverst i Nordre gate, før 1899" type:InfoTypePhoto description:@"Bildet viser øverst i Nordre gate, sett fra Kongens gate og nedover. Mange mennesker ute i gata. \n \nBildet er tatt fra boka Gamle Trondhjem i Billeder, samlet og utgitt av Alb. Emil Kock, november 1910." location:l14 year:(NSInteger)1899  imagePath:@"/UBT-TO-076320.jpg" ];
    
    ARGeoCoordinate *c14 = [[ARGeoCoordinate alloc] initWithCoordinate:l14 andInfo:photo14];
    [self.arController addCoordinate:c14 animated:NO];
    
    CLLocation *l15 = [[CLLocation alloc] initWithLatitude:63.43040432627032 longitude:10.397787094116211];
    Photo *photo15 = [[Photo alloc] initPhotoWithTitle:@"Øverst i Nordre gate, 1907" type:InfoTypePhoto description:@"UBildet viser utsikt necover Nordre gate sett fra Vår Frue kirke. \n \nBildet er tatt av H.Werner og donert av ingeniør Breder." location:l15 year:(NSInteger)1907 imagePath:@"/UBT-TO-004725.jpg" ];
    
    ARGeoCoordinate *c15 = [[ARGeoCoordinate alloc] initWithCoordinate:l15 andInfo:photo15];
    [self.arController addCoordinate:c15 animated:NO];
    
    CLLocation *l16 = [[CLLocation alloc] initWithLatitude:63.43068505717949 longitude:10.397526919841766];
    Photo *photo16 = [[Photo alloc] initPhotoWithTitle:@"Bruns bokhandel, 1915" type:InfoTypePhoto description:@"Bildet viser Bruns bokhandel i øverste del av Nordre gate. \n \nBildet ble tatt av J. H. Küenholdt og donert av Helga Sand." location:l16 year:(NSInteger)1915  imagePath:@"/UBT-TO-004714.jpg"];
    
    ARGeoCoordinate *c16 = [[ARGeoCoordinate alloc] initWithCoordinate:l16 andInfo:photo16];
    [self.arController addCoordinate:c16 animated:NO];
    
    // Add stores
    CLLocation *l17 = [[CLLocation alloc] initWithLatitude:63.430588 longitude:10.397919];
    Store *store1 = [[Store alloc] initStoreWithTitle:@"Kongens gate 8" type:InfoTypeStore description:@"Børskomiteen  kjøpte i 1858 den gamle Blichfeldtgården, rev den og oppførte Børs-, Telegraf- og Postbygningen på tomten. \n \nKjøpesenteret Mercursenteret ble etablert i bygget i 1997. Senteret har fått sitt navn etter statuen av Merkur som tidligere sto på utsiden av bygget. Merkur er handelens og tyvenes gud. Orginalstatuen av ham står nå inne i senteret mens en kopi er satt i nisjen utenfor." location:l17 address:@"Telegrafgården"];
    
    ARGeoCoordinate *c17 = [[ARGeoCoordinate alloc] initWithCoordinate:l17 andInfo:store1];
    [self.arController addCoordinate:c17 animated:NO];
    
    CLLocation *l18 = [[CLLocation alloc] initWithLatitude:63.430585 longitude:10.397532];
    Store *store2 = [[Store alloc] initStoreWithTitle:@"Kongens gate 10" type:InfoTypeStore description:@"Brungården ble kjøpt av bokhandler Andreas Brun i 1886. Hans familie drev bokhandel i bygget fram til 2000. I 2000 ble bokhandelen solgt, men bygget tilhører fremdeles familien Brun." location:l18 address:@"Bruns bokhandel"];
    
    ARGeoCoordinate *c18 = [[ARGeoCoordinate alloc] initWithCoordinate:l18 andInfo:store2];
    [self.arController addCoordinate:c18 animated:NO];
    
    CLLocation *l19 = [[CLLocation alloc] initWithLatitude:63.431035 longitude:10.397865];
    Store *store3 = [[Store alloc] initStoreWithTitle:@"Nordre gate 1" type:InfoTypeStore description:@"Bygget, som muligens ble oppført like etter bybrannen i 1708, rommet på 1800-tallet et losjihus. Fra midten av 1890-årene rommet gården flere forretninger og hadde leiligheter i annen etasje. I en av disse vokste anarkisten og forfatteren Arne Dybfest opp. Kinodirektør Paul Krausslich kjøpte gården i 1909. Fra 1910 av drev han kinoen Krausslichs Kosmorama i bygget mens han selv bodde i en leilighet i annen etasje. Fra 1912 holdt også Centralcafeen til i annen etasje. Denne kaféen ble i 1916 etterfulgt av Iris Café og Thesalon. I 1918 kjøpte Adresseavisen gården og leide ut kinolokalet til lagerfirmaet Per Kure. I 1925 flyttet Adresseavisens redaksjon inn i lokalet. " location:l19 address:@"Adresseavisens bygg"];
    
    ARGeoCoordinate *c19 = [[ARGeoCoordinate alloc] initWithCoordinate:l19 andInfo:store3];
    [self.arController addCoordinate:c19 animated:NO];
    
    CLLocation *l20 = [[CLLocation alloc] initWithLatitude:63.43117 longitude:10.397857];
    Store *store4 = [[Store alloc] initStoreWithTitle:@"Nordre gate 3" type:InfoTypeStore description:@"I bygget var det barbersalon fram til 1918. Senere flyttet Dopheides Magasin A/S inn i lokalene." location:l20 address:@"Barbersalon og magasin"];
    
    ARGeoCoordinate *c20 = [[ARGeoCoordinate alloc] initWithCoordinate:l20 andInfo:store4];
    [self.arController addCoordinate:c20 animated:NO];
    
    CLLocation *l21 = [[CLLocation alloc] initWithLatitude:63.431287 longitude:10.397827];
    Store *store5 = [[Store alloc] initStoreWithTitle:@"Nordre gate 5" type:InfoTypeStore description:@"Fjeldseth Elektriske Installationsbyraa ble etablert i 1900 og holdt i mange år til i dette bygget. Firmaet eksisterer den dag i dag under navnet Fjeldseth AS." location:l21 address:@"Fjeldseth Elektriske Installationsbyraa"];
    
    ARGeoCoordinate *c21 = [[ARGeoCoordinate alloc] initWithCoordinate:l21 andInfo:store5];
    [self.arController addCoordinate:c21 animated:NO];
    
    CLLocation *l22 = [[CLLocation alloc] initWithLatitude:63.431402 longitude:10.397814];
    Store *store6 = [[Store alloc] initStoreWithTitle:@"Nordre gate 7" type:InfoTypeStore description:@"Bygget har huset mange forretninger opp gjennom årene. Bare i årene før 1925 rakk bygget å huse en skotøiforretning, en skrædderforretning, en modeforretning og en hanskemagerforretning." location:l20 address:@"Sko-, skredder- og moteforretning"];
    
    ARGeoCoordinate *c22 = [[ARGeoCoordinate alloc] initWithCoordinate:l22 andInfo:store6];
    [self.arController addCoordinate:c22 animated:NO];
    
    CLLocation *l23 = [[CLLocation alloc] initWithLatitude:63.431534 longitude:10.397787];
    Store *store7 = [[Store alloc] initStoreWithTitle:@"Nordre gate 9" type:InfoTypeStore description:@"Bygget er en forretningsgård i jugendstil oppført i 1903. Tidlig på 1900-tallet holdt Johan F. Svendsens bok-, kunst-, papir- og musikhandel og Falchs Eftf Jul Johansens ur- og kronometerforretning til i bygget. Gullsmed Ole Aas flyttet inn i bygget i 2007 etter å ha holdt til i Dronningens gate 24 siden 1904." location:l23 address:@"Forretningsgård i jugendstil"];
    
    ARGeoCoordinate *c23 = [[ARGeoCoordinate alloc] initWithCoordinate:l23 andInfo:store7];
    [self.arController addCoordinate:c23 animated:NO];
    
    CLLocation *l24 = [[CLLocation alloc] initWithLatitude:63.430884 longitude:10.397511];
    Store *store8 = [[Store alloc] initStoreWithTitle:@"Nordre gate 2" type:InfoTypeStore description:@"Den første optiske forretningen i bygget ble grunnlagt i 1869 av instrumentmaker Godager. Optikus H. Iversen overtok bedriften i 1886 og forretningen har fremdeles hans navn. En stund holdt firmaets kompassfabrikk til i samme bygg, men de ble skilt ut som eget firma i 1919. " location:l20 address:@"Iversen Optikk"];
    
    ARGeoCoordinate *c24 = [[ARGeoCoordinate alloc] initWithCoordinate:l24 andInfo:store8];
    [self.arController addCoordinate:c24 animated:NO];
    
    CLLocation *l25 = [[CLLocation alloc] initWithLatitude:63.431019 longitude:10.397463];
    Store *store9 = [[Store alloc] initStoreWithTitle:@"Nordre gate 4" type:InfoTypeStore description:@"Bygget huset på tidlig 1900-tall Hahn Konditori og kafé. Rundt 1920 flyttet Centralvaskeriet inn i bygget.  På samme tid ble konditoriet erstattet av Anglaise café & thesalon." location:l25 address:@"Kafé og vaskeri"];
    
    ARGeoCoordinate *c25 = [[ARGeoCoordinate alloc] initWithCoordinate:l25 andInfo:store9];
    [self.arController addCoordinate:c25 animated:NO];
    
    CLLocation *l26 = [[CLLocation alloc] initWithLatitude:63.431179 longitude:10.39743];
    Store *store10 = [[Store alloc] initStoreWithTitle:@"Nordre gate 6" type:InfoTypeStore description:@"Gården ble i 1907 solgt til fotograf Alf Schrøder. I de første årene holdt han til i bakgården mens resten av bygget huset en rekke andre forretninger, blant annet en tricotageforretning, en korsetfabrik og en frugtekspedisjon. \n \nDet opprinnelige bygget ble revet i 1966, men firmaet Fotograf Schrøder A/S holder fremdeles til på samme adresse." location:l26 address:@"Schrødergården"];
    
    ARGeoCoordinate *c26 = [[ARGeoCoordinate alloc] initWithCoordinate:l26 andInfo:store10];
    [self.arController addCoordinate:c26 animated:NO];
    
    CLLocation *l27 = [[CLLocation alloc] initWithLatitude:63.431402 longitude:10.39743];
    Store *store11 = [[Store alloc] initStoreWithTitle:@"Nordre gate 8" type:InfoTypeStore description:@"Eiendommen ble i 1912 kjøpt av fabrikkeier Ole Erichsens. Han rev den gamle tregården og oppførte den nåværende murgården på tomten. Fra 1914 og frem til 2007 rommet gården Erichsens konditori." location:l27 address:@"Erichsengården"];
    
    ARGeoCoordinate *c27 = [[ARGeoCoordinate alloc] initWithCoordinate:l27 andInfo:store11];
    [self.arController addCoordinate:c27 animated:NO];
    
    CLLocation *l28 = [[CLLocation alloc] initWithLatitude:63.431605 longitude:10.397391];
    Store *store12 = [[Store alloc] initStoreWithTitle:@"Nordre gate 10" type:InfoTypeStore description:@"Tidlig på 1900-tallet huset bygget et parfymeri og en tobakksforretning. Opp gjennnom årene endret butikkene stadig navn. I adresseboken fra 1913 er det Nissen parfume & drogeriforretning som holder til i bygget sammen med Husby tobak, cigar & vinforretning. I 1919 er det samme butikker som holder til i bygget, men de heter nå Nissen parfumeriforretning og Husby tobaksforretning." location:l28 address:@"Parfymeri og tobakksforretning"];
    
    ARGeoCoordinate *c28 = [[ARGeoCoordinate alloc] initWithCoordinate:l28 andInfo:store12];
    [self.arController addCoordinate:c28 animated:NO];
    
    }

@end
