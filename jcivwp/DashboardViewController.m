//
//  DashboardViewController.m
//  jcivwp
//
//  Created by 179159 on 18/05/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import "DashboardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "MaterialList.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

@synthesize  alarmText,materialTable,buttonFlashing_run,buttonFlashing_alarm,buttonFlashing_stop,agvStatus_running,agvStatus_alarm,agvStatus_stopped,status_alarm,status_run,status_stop,home_flag,store_flag,st1_flag,st2_flag,st3_flag,st4_flag,st5_flag,move_home,move_st1,move_st2,move_st3,move_st4,move_st5,move_store,dashLine;
// move_home_flag,move_store_flag,move_st1_flag,move_st2_flag,move_st3_flag,move_st4_flag,move_st5_flag,
//direct_14,direct_19,direct_23,direct_26,direct_28,direct_8,direct_9,direct_10,direct_11,direct_12,direct_13,direct_15,direct_16,direct_17,direct_18,direct_20,direct_21,direct_22,direct_24,direct_25,direct_27;

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
    // Do any additional setup after loading the view.
    self.alarmText.layer.masksToBounds = YES;
    self.alarmText.layer.cornerRadius = 8;
//    self.materialTable.contentInset = UIEdgeInsetsMake(0, 0, self.materialTable.frame.size.height - 20, 0);
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseResponse) name:@"pushNotification" object:nil];
    
//    UIColor *patternColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern"]];
//    self.view.backgroundColor = patternColor;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (IBAction)logout:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = YES;
    
    [self.navigationItem setHidesBackButton:YES animated:YES];
    
    self.buttonFlashing_run = NO;
    self.buttonFlashing_stop = NO;
    self.buttonFlashing_alarm = NO;
    self.alarmText.text = @"Alarm Text";
    
    [self.agvStatus_running setImage:[UIImage imageNamed:@"arrow_a.png"] forState:UIControlStateNormal];
    [self.agvStatus_stopped setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
    [self.agvStatus_alarm setImage:[UIImage imageNamed:@"alar.png"] forState:UIControlStateNormal];
    
    
    [self.status_stop setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    [self.status_stop setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    [self.status_stop setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    
    [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
    [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
    [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
    [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
    [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
    [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
    
//    self.move_home_flag = NO;self.move_store_flag = NO; self.move_st1_flag = NO; self.move_st2_flag = NO;
//    self.move_st3_flag = NO; self.move_st4_flag = NO; self.move_st5_flag = NO;
    
    self.move_home.hidden = YES; self.move_st3.hidden = YES;
    self.move_st1.hidden = YES; self.move_st4.hidden = YES;
    self.move_st2.hidden = YES; self.move_st5.hidden = YES;
    self.move_store.hidden = YES;
    
    self.dashLine.hidden = YES;
    
    self.home_flag = NO; self.store_flag = NO; self.st1_flag = NO;
    self.st2_flag = NO; self.st3_flag= NO; self.st4_flag = NO; self.st5_flag =NO;

//    direct_9.hidden=YES; direct_8.hidden = YES; direct_28.hidden= YES; direct_26.hidden = YES;
//    direct_23.hidden = YES; direct_19.hidden = YES; direct_14.hidden = YES;
//    direct_10.hidden = YES; direct_11.hidden = YES; direct_12.hidden = YES; direct_13.hidden = YES;
//    direct_15.hidden = YES; direct_16.hidden = YES; direct_17.hidden = YES; direct_18.hidden = YES;
//    direct_20.hidden = YES; direct_21.hidden = YES; direct_22.hidden = YES;direct_24.hidden = YES;
//    direct_25.hidden = YES; direct_27.hidden = YES; 

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIImage *myImage = [UIImage imageNamed:@"cell_row.png"];
//    UIImage *myImage = [UIImage image]
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:myImage] init];
    imageView.frame = CGRectMake(0,0,1024,74);
    
    UILabel *lblTitle_demand = [[UILabel alloc] initWithFrame:CGRectMake(20,3, 100 ,30)];
    lblTitle_demand.text = @"Demand";
    lblTitle_demand.textColor = [UIColor blackColor];
    lblTitle_demand.font = [UIFont fontWithName:@"Helvetica" size:22];
    [imageView addSubview:lblTitle_demand];
    
    UILabel *lblTitle_material = [[UILabel alloc] initWithFrame:CGRectMake(80,34, 100 ,30)];
    lblTitle_material.text = @"Material No";
    lblTitle_material.textColor = [UIColor colorWithRed:(138.0f/255.0f) green:(138.0f/255.0f) blue:(140.0f/255.0f) alpha:1.0];
    lblTitle_material.font = [UIFont fontWithName:@"Helvetica" size:14];
    [imageView addSubview:lblTitle_material];

    UILabel *lblTitle_quantity = [[UILabel alloc] initWithFrame:CGRectMake(250,34, 100 ,30)];
    lblTitle_quantity.text = @"Quantity";
    lblTitle_quantity.textColor = [UIColor colorWithRed:(138.0f/255.0f) green:(138.0f/255.0f) blue:(140.0f/255.0f) alpha:1.0];
    lblTitle_quantity.font = [UIFont fontWithName:@"Helvetica" size:14];
    [imageView addSubview:lblTitle_quantity];

    UILabel *lblTitle_availability = [[UILabel alloc] initWithFrame:CGRectMake(450,34, 100 ,30)];
    lblTitle_availability.text = @"Availability";
    lblTitle_availability.textColor = [UIColor colorWithRed:(138.0f/255.0f) green:(138.0f/255.0f) blue:(140.0f/255.0f) alpha:1.0];
    lblTitle_availability.font = [UIFont fontWithName:@"Helvetica" size:14];
    [imageView addSubview:lblTitle_availability];

    UILabel *lblTitle_stationNo = [[UILabel alloc] initWithFrame:CGRectMake(650,34, 100 ,30)];
    lblTitle_stationNo.text = @"Station No";
    lblTitle_stationNo.textColor = [UIColor colorWithRed:(138.0f/255.0f) green:(138.0f/255.0f) blue:(140.0f/255.0f) alpha:1.0];
    lblTitle_stationNo.font = [UIFont fontWithName:@"Helvetica" size:14];
    [imageView addSubview:lblTitle_stationNo];

    UILabel *lblTitle_delivery = [[UILabel alloc] initWithFrame:CGRectMake(850,34, 100 ,30)];
    lblTitle_delivery.text = @"Delivery";
    lblTitle_delivery.textColor = [UIColor colorWithRed:(138.0f/255.0f) green:(138.0f/255.0f) blue:(140.0f/255.0f) alpha:1.0];
    lblTitle_delivery.font = [UIFont fontWithName:@"Helvetica" size:14];
    [imageView addSubview:lblTitle_delivery];
    
    return imageView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 74;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    AppDelegate *appdelegate =   [[UIApplication sharedApplication] delegate];
    return [appdelegate.materialList count];
}

- (void)parseResponse
{
    AppDelegate *appdelegate  =  [[UIApplication sharedApplication] delegate];

    /// Resposne for Kanban Trigger
    if ([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"type"] isEqualToString:@"5"]) {
        
        ///material List message at the time of kanban trigger
        NSMutableArray *list = [[NSMutableArray alloc]init];
        list = [[appdelegate.response objectForKey:@"aps"] valueForKey:@"matlist"];
        [appdelegate.materialList removeAllObjects];
        
        for (NSDictionary *dic in list){
            MaterialList *ml = [[MaterialList alloc]init];
            ml.materialID = [dic valueForKey:@"mtl"];
            ml.quantity = [dic valueForKey:@"qty"];
            ml.station = [dic valueForKey:@"stn"];
            ml.availability = @"---";
            ml.delivery = @"---";
            [appdelegate.materialList addObject:ml];
        }
        
        [self.materialTable reloadData];
    }
       /// Resposne for Material Placement
    if ([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"type"] isEqualToString:@"3"]) {
       
        NSString *search = [[appdelegate.response objectForKey:@"aps"] valueForKey:@"material"];
        for(int i = 0; i< [appdelegate.materialList count]; i++)
        {
            MaterialList *ml = [appdelegate.materialList objectAtIndex:i];
            if ([ml.materialID isEqualToString:search])
            {
                ml.availability = @"YES";
                [appdelegate.materialList replaceObjectAtIndex:i withObject:ml];
                
            }
            
        }
        [self.materialTable reloadData];
    }

           /// Resposne for Material Delivery
    if ([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"type"] isEqualToString:@"4"]) {
        
        NSString *search = [[appdelegate.response objectForKey:@"aps"] valueForKey:@"material"];
        for(int i = 0; i< [appdelegate.materialList count]; i++)
        {
            MaterialList *ml = [appdelegate.materialList objectAtIndex:i];
            if ([ml.materialID isEqualToString:search])
            {
                ml.delivery = @"YES";
                [appdelegate.materialList replaceObjectAtIndex:i withObject:ml];
                
            }
            
        }
        [self.materialTable reloadData];
    }
    
           /// Resposne for Health Parameter
    if ([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"type"] isEqualToString:@"2"])
    {

        NSString *status = [[appdelegate.response objectForKey:@"aps"] valueForKey:@"status"];
        NSString *alarm = [[appdelegate.response objectForKey:@"aps"] valueForKey:@"alarm"];
        
        if([status  isEqualToString:@"1"])
        {
            [self.agvStatus_running setImage:[UIImage imageNamed:@"arrow_1.png"] forState:UIControlStateNormal];
            [self.agvStatus_stopped setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
            [self.agvStatus_alarm setImage:[UIImage imageNamed:@"alar.png"] forState:UIControlStateNormal];
            
            [self.status_run setTitleColor:[UIColor colorWithRed:(65.0f/255.0f) green:(146.0f/255.0f) blue:(26.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [self.status_stop setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [self.status_alarm setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            
            [self startFlashingbutton_running];
            [self stopFlashingbutton_stopped];
            [self stopFlashingbutton_alarm];
            
            self.alarmText.text = @"Alarm Text";
        }
        
        if ([status isEqualToString:@"2"]) {
            
            [self.agvStatus_running setImage:[UIImage imageNamed:@"arrow_a.png"] forState:UIControlStateNormal];
            [self.agvStatus_stopped setImage:[UIImage imageNamed:@"stop_1.png"] forState:UIControlStateNormal];
            [self.agvStatus_alarm setImage:[UIImage imageNamed:@"alar.png"] forState:UIControlStateNormal];
            
            [self.status_stop setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(52.0f/255.0f) blue:(52.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [self.status_run setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [self.status_alarm setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            
            
                [self stopFlashingbutton_running];
                [self startFlashingbutton_stopped];
                [self stopFlashingbutton_alarm];
                self.alarmText.text = @"Alarm Text";
        }
        
        if([status isEqualToString:@"3"]){
            
                self.alarmText.text = alarm;
            
            [self.agvStatus_running setImage:[UIImage imageNamed:@"arrow_a.png"] forState:UIControlStateNormal];
            [self.agvStatus_stopped setImage:[UIImage imageNamed:@"stop.png"] forState:UIControlStateNormal];
            [self.agvStatus_alarm setImage:[UIImage imageNamed:@"alar_1.jpg"] forState:UIControlStateNormal];
            
            [self.status_alarm setTitleColor:[UIColor colorWithRed:(255.0f/255.0f) green:(52.0f/255.0f) blue:(52.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [self.status_stop setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            [self.status_run setTitleColor:[UIColor colorWithRed:(206.0f/255.0f) green:(206.0f/255.0f) blue:(208.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
            
               [self stopFlashingbutton_running];
               [self stopFlashingbutton_stopped];
               [self startFlashingbutton_alarm];
        }
        
    
    }
    
      /// Resposne for Location Telemetry
    if ([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"type"] isEqualToString:@"1"])
    {
        
     NSDictionary *locDetails =  [appdelegate.lookupTable objectForKey:[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc" ]];
        
        if ([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"1"] || [[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"2"] ||
            [[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"3"] ||
            [[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"4"] ||
            [[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"5"] ||
            [[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"6"] ||
            [[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"7"]) {
            
            NSString *source = [locDetails valueForKey:@"source"];
            if([source isEqualToString:@"move_home"]){
//                self.move_home.hidden = NO; self.move_st2.hidden = YES;
//                self.move_store.hidden = YES; self.move_st3.hidden = YES;
//                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
//                self.move_st5.hidden = YES;
//                
//                direct_8.hidden = YES; direct_9.hidden = YES; direct_28.hidden = YES;
//                direct_26.hidden = YES; direct_23.hidden = YES; direct_19.hidden = YES;
//                direct_14.hidden = YES;
//                direct_10.hidden = YES; direct_11.hidden = YES; direct_13.hidden = YES;
//                direct_12.hidden = YES; direct_15.hidden = YES; direct_16.hidden = YES;
//                direct_17.hidden = YES; direct_18.hidden = YES; direct_20.hidden = YES;
//                direct_21.hidden = YES; direct_22.hidden = YES; direct_24.hidden = YES;
//                direct_25.hidden = YES; direct_27.hidden = YES;

                  [self startFlashing_home];
                  [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                  [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                  [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                  [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                  [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                  [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
//                [self stopFlashingloc_station1];[self stopFlashingloc_station4];
//                [self stopFlashingloc_station2];[self stopFlashingloc_station3];
//                [self stopFlashingloc_station5]; [self stopFlashingloc_store];
                
                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_st5];
                [self stopFlashingbutton_store];
            }
            
            if([source isEqualToString:@"move_store"]){
//                self.move_home.hidden = YES; self.move_st2.hidden = YES;
//                self.move_store.hidden = NO; self.move_st3.hidden = YES;
//                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
//                self.move_st5.hidden = YES;
//                
//                direct_8.hidden = YES; direct_9.hidden = YES; direct_28.hidden = YES;
//                direct_26.hidden = YES; direct_23.hidden = YES; direct_19.hidden = YES;
//                direct_14.hidden = YES; direct_10.hidden = YES; direct_11.hidden = YES; direct_13.hidden = YES;direct_12.hidden = YES; direct_15.hidden = YES; direct_16.hidden = YES;
//                direct_17.hidden = YES; direct_18.hidden = YES;direct_20.hidden = YES;
//                direct_21.hidden = YES;direct_22.hidden = YES;direct_24.hidden = YES;
//                direct_25.hidden = YES;direct_27.hidden = YES;
                
//                [self startFlashingloc_store];
//                [self stopFlashingloc_station1];[self stopFlashingloc_station4];
//                [self stopFlashingloc_station2];[self stopFlashingloc_station3];
//                [self stopFlashingloc_station5];[self stopFlashingloc_home];
//
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                [self.store setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
                [self startFlashing_store];
                [self stopFlashingbutton_st2];[self stopFlashingbutton_st1];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
                
//
                
            }
            if([source isEqualToString:@"move_st1"]){
//                self.move_home.hidden = YES; self.move_st2.hidden = YES;
//                self.move_store.hidden = YES; self.move_st3.hidden = YES;
//                self.move_st1.hidden = NO; self.move_st4.hidden = YES;
//                self.move_st5.hidden = YES;
//                
//                direct_8.hidden = YES; direct_9.hidden = YES; direct_28.hidden = YES;
//                direct_26.hidden = YES; direct_23.hidden = YES; direct_19.hidden = YES;
//                direct_14.hidden = YES;direct_10.hidden = YES; direct_11.hidden = YES;
//                direct_13.hidden = YES;direct_12.hidden = YES; direct_15.hidden = YES;
//                direct_16.hidden = YES;
//                direct_17.hidden = YES; direct_18.hidden = YES; direct_20.hidden = YES;
//                direct_21.hidden = YES; direct_22.hidden = YES;direct_24.hidden = YES;
//                direct_25.hidden = YES; direct_27.hidden = YES;
                
//                [self startFlashingloc_station1];
//                [self stopFlashingloc_station2];[self stopFlashingloc_station3];
//                [self stopFlashingloc_station5];[self stopFlashingloc_home];
//                [self stopFlashingloc_store]; [self stopFlashingloc_station4];
//                
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                [self startFlashing_station1]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store];
                
            }
            if([source isEqualToString:@"move_st2"]){
//                self.move_home.hidden = YES; self.move_st2.hidden = NO;
//                self.move_store.hidden = YES; self.move_st3.hidden = YES;
//                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
//                self.move_st5.hidden = YES;
//                
//                direct_8.hidden = YES;  direct_9.hidden = YES; direct_28.hidden = YES;
//                direct_26.hidden = YES; direct_23.hidden = YES; direct_19.hidden = YES;
//                direct_14.hidden = YES; direct_10.hidden = YES; direct_11.hidden = YES;
//                direct_13.hidden = YES; direct_12.hidden = YES; direct_15.hidden = YES;
//                direct_16.hidden = YES;
//                direct_17.hidden = YES; direct_18.hidden = YES; direct_20.hidden = YES;
//                direct_21.hidden = YES; direct_22.hidden = YES; direct_24.hidden = YES;
//                direct_25.hidden = YES; direct_27.hidden = YES;
                
//                [self startFlashingloc_station2];
//                
//                [self stopFlashingloc_station1];[self stopFlashingloc_station3];
//                [self stopFlashingloc_station5];[self stopFlashingloc_home];
//                [self stopFlashingloc_store]; [self stopFlashingloc_station4];
//                
//                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
//                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
//                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
//                [self stopFlashingbutton_store];
                
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                [self startFlashing_station2]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store];
                
                
            }
            if([source isEqualToString:@"move_st3"]){
//                self.move_home.hidden = YES; self.move_st2.hidden = YES;
//                self.move_store.hidden = YES; self.move_st3.hidden = NO;
//                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
//                self.move_st5.hidden = YES;
//                
//                direct_8.hidden = YES;  direct_9.hidden = YES; direct_28.hidden = YES;
//                direct_26.hidden = YES; direct_23.hidden = YES; direct_19.hidden = YES;
//                direct_14.hidden = YES; direct_10.hidden = YES; direct_11.hidden = YES;
//                direct_13.hidden = YES; direct_12.hidden = YES;direct_15.hidden = YES;
//                direct_16.hidden = YES;
//                direct_17.hidden = YES; direct_18.hidden = YES; direct_20.hidden = YES;
//                direct_21.hidden = YES; direct_22.hidden = YES;direct_24.hidden = YES;
//                direct_25.hidden = YES; direct_27.hidden = YES;
                
//                [self startFlashingloc_station3];
//                [self stopFlashingloc_station2];[self stopFlashingloc_station1];
//                [self stopFlashingloc_station5];[self stopFlashingloc_home];
//                [self stopFlashingloc_store]; [self stopFlashingloc_station4];
//                
//                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
//                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
//                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
//                [self stopFlashingbutton_store];
                
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                [self startFlashing_station3]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store];
                
                
            }
            if([source isEqualToString:@"move_st4"]){
//                self.move_home.hidden = YES; self.move_st2.hidden = YES;
//                self.move_store.hidden = YES; self.move_st3.hidden = YES;
//                self.move_st1.hidden = YES; self.move_st4.hidden = NO;
//                self.move_st5.hidden = YES;
//                
//                direct_8.hidden = YES;  direct_9.hidden = YES;  direct_28.hidden = YES;
//                direct_26.hidden = YES; direct_23.hidden = YES; direct_19.hidden = YES;
//                direct_14.hidden = YES; direct_10.hidden = YES; direct_11.hidden = YES;
//                direct_13.hidden = YES; direct_12.hidden = YES; direct_15.hidden = YES;
//                direct_16.hidden = YES; direct_17.hidden = YES; direct_18.hidden = YES;
//                direct_20.hidden = YES; direct_21.hidden = YES; direct_22.hidden = YES;
//                direct_24.hidden = YES; direct_25.hidden = YES; direct_27.hidden = YES;
                
//                [self startFlashingloc_station4];
//                [self stopFlashingloc_station2];[self stopFlashingloc_station3];
//                [self stopFlashingloc_station5];[self stopFlashingloc_home];
//                [self stopFlashingloc_store]; [self stopFlashingloc_station1];
//                
//                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
//                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
//                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
//                [self stopFlashingbutton_store];
                
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                [self startFlashing_station4]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store];
                
            }
            if([source isEqualToString:@"move_st5"]){
//                self.move_home.hidden = YES; self.move_st2.hidden = YES;
//                self.move_store.hidden = YES; self.move_st3.hidden = YES;
//                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
//                self.move_st5.hidden = NO;
//                
//                direct_8.hidden = YES; direct_9.hidden = YES; direct_28.hidden = YES;
//                direct_26.hidden = YES; direct_23.hidden = YES; direct_19.hidden = YES;
//                direct_14.hidden = YES;
//                direct_10.hidden = YES; direct_11.hidden = YES; direct_13.hidden = YES;
//                direct_12.hidden = YES; direct_15.hidden = YES; direct_16.hidden = YES;
//                direct_17.hidden = YES; direct_18.hidden = YES; direct_20.hidden = YES;
//                direct_21.hidden = YES; direct_22.hidden = YES;direct_24.hidden = YES;
//                direct_25.hidden = YES; direct_27.hidden = YES;
                
//                [self startFlashingloc_station5];
//                [self stopFlashingloc_station2];[self stopFlashingloc_station3];
//                [self stopFlashingloc_station1];[self stopFlashingloc_home];
//                [self stopFlashingloc_store]; [self stopFlashingloc_station4];
//                
//                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
//                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
//                [self stopFlashingbutton_st5]; [self stopFlashingbutton_home];
//                [self stopFlashingbutton_store];
                
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5.png"] forState:UIControlStateNormal];
                
                [self startFlashing_station5]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_st4]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store];
            }
            
        }
        
        else{
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"8"])
            {

                
                [self.store setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
                
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                //    [self.move_home setImage:[UIImage imageNamed:@"s_strip.png"] forState:UIControlStateNormal];
                //    [self.move_home setFrame:CGRectMake(62,130,10,20)];
                
                self.move_store.hidden = NO;
                //    self.move_home.hidden = NO;
                
                self.move_st1.hidden = YES; self.move_st3.hidden = YES;
                self.move_st2.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_home]; [self startFlashing_store];
                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_st5];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(62,438,150,6);
                
                [self.view addSubview:dashLine];
                

           }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"9"])
            {
                
            // Store --> Station1
                [self.store setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
                
                [self.station1 setImage:[UIImage imageNamed:@"unit_1.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st1.hidden = NO; self.move_st3.hidden = YES;
                self.move_st2.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_store]; [self startFlashing_station1];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_st4]; [self stopFlashingbutton_st5];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(212,438,150,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"10"])
            {
                // Store ---> Station2
                [self.store setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
                
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = NO; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_store]; [self startFlashing_station2];
                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_st4]; [self stopFlashingbutton_st5];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(212,438,287,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"11"])
            {
                //                // Store ---> Station3
                [self.store setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
                
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = NO;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_store]; [self startFlashing_station3];
                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_st4]; [self stopFlashingbutton_st5];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(212,438,430,6);
                
                [self.view addSubview:dashLine];

            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"12"]) {
                // Store ----> Station 4
                [self.store setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
                
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = NO;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_store]; [self startFlashing_station4];
                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st5];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(212,438,572,6);
                
                [self.view addSubview:dashLine];
                
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"13"])
            {
                [self.store setImage:[UIImage imageNamed:@"store.png"] forState:UIControlStateNormal];
                
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = NO; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_store]; [self startFlashing_station5];
                [self stopFlashingbutton_st1]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(212,438,732,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"14"])
            {
                //Sta1 ----> Sta2
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = NO; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station1]; [self startFlashing_station2];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(360,438,140,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"15"])
            {
             // Sta1 ---> Sta3
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = NO;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station1]; [self startFlashing_station3];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(360,438,280,6);
                
                [self.view addSubview:dashLine];
            }
            
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"16"])
            {
                // Sta1 ---> Sta4
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = NO;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station1]; [self startFlashing_station4];
                [self stopFlashingbutton_st5]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(360,438,420,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"17"])
            {
                //Sta1 ---> Sta5
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = NO; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station1]; [self startFlashing_station5];
                [self stopFlashingbutton_st4]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(360,438,584,6);
                
                [self.view addSubview:dashLine];

            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"18"]){
            //Sta1 --> Home
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = NO;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_home]; [self startFlashing_station1];
                [self stopFlashingbutton_st4]; [self stopFlashingbutton_st2];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_st5];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(360,438,584,6);
                
                [self.view addSubview:dashLine];

                
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"19"])
            {
                //Sta2 ---> Sta3
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = NO;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station2]; [self startFlashing_station3];
                [self stopFlashingbutton_st4]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st5];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(500,438,140,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"20"]){
                //Sta2--->Sta4
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = NO;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station4]; [self startFlashing_station2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st5];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(500,438,280,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"21"])
            {
                //Sta2--> Sta5
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = NO; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station5]; [self startFlashing_station2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_home];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st4];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(500,438,445,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"22"])
            {
                //Sta2---> Home
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = NO;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_home]; [self startFlashing_station2];
                [self stopFlashingbutton_st3]; [self stopFlashingbutton_st5];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st4];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(62,438,445,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"23"]){
                //Sta3 ---> Sta4
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = NO;
                self.move_st5.hidden = YES; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station4]; [self startFlashing_station3];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st5];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(640,438,145,6);
                
                [self.view addSubview:dashLine];

            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"24"])
            {
                //Sta3 ---> Sta5
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = NO; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station5]; [self startFlashing_station3];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(640,438,305,6);
                
                [self.view addSubview:dashLine];

            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"25"]){
                ///Str3---> Home
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = NO;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_home]; [self startFlashing_station3];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st4];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st5];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(640,438,300,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"26"]){
                //Sta4 ---> Sta5
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5.png"] forState:UIControlStateNormal];
                
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = NO; self.move_home.hidden = YES;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_station5]; [self startFlashing_station4];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_home];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(780,438,165,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"27"])
            {
                //Sta4--> Home
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5_a.png"] forState:UIControlStateNormal];
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = NO;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_home]; [self startFlashing_station4];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st5];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(62,438,730,6);
                
                [self.view addSubview:dashLine];
            }
            
            if([[[appdelegate.response objectForKey:@"aps"] valueForKey:@"loc"] isEqualToString:@"28"]){
                //Sta5 ---> Home
                [self.store setImage:[UIImage imageNamed:@"store_a.png"] forState:UIControlStateNormal];
                [self.station1 setImage:[UIImage imageNamed:@"unit_1_a.png"] forState:UIControlStateNormal];
                [self.station2 setImage:[UIImage imageNamed:@"unit_2_b.png"] forState:UIControlStateNormal];
                [self.station3 setImage:[UIImage imageNamed:@"unit_3_c.png"] forState:UIControlStateNormal];
                [self.station4 setImage:[UIImage imageNamed:@"unit_4_d.png"] forState:UIControlStateNormal];
                [self.station5 setImage:[UIImage imageNamed:@"unit_5.png"] forState:UIControlStateNormal];
                
                self.move_st2.hidden = YES; self.move_st3.hidden = YES;
                self.move_st1.hidden = YES; self.move_st4.hidden = YES;
                self.move_st5.hidden = YES; self.move_home.hidden = NO;
                self.move_store.hidden = YES;
                
                self.dashLine.hidden = NO;
                
                [self startFlashing_home]; [self startFlashing_station5];
                [self stopFlashingbutton_st2]; [self stopFlashingbutton_st3];
                [self stopFlashingbutton_store]; [self stopFlashingbutton_st1];
                [self stopFlashingbutton_st4];
                
                UIImage *progress = [UIImage imageNamed:@"g_line.png"];
                self.dashLine.image = progress;
                self.dashLine.frame = CGRectMake(62,438,885,6);
                
                [self.view addSubview:dashLine];
            }
        }
        
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Notification" message:
//                              [locDetails valueForKey:@"source"] delegate:nil cancelButtonTitle:
//                              @"OK" otherButtonTitles:nil, nil];
//        [alert show];
        
    
    }
    
}


- (void) startFlashingbutton_running
{
    
    if (buttonFlashing_run) return;
    buttonFlashing_run = YES;
    
    
    self.agvStatus_running.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.agvStatus_running.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) startFlashingbutton_stopped
{
    if (buttonFlashing_stop) return;
    buttonFlashing_stop = YES;
    
    self.agvStatus_stopped.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.agvStatus_stopped.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) startFlashingbutton_alarm
{
    if (buttonFlashing_alarm) return;
    buttonFlashing_alarm = YES;
    
    self.agvStatus_alarm.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.agvStatus_alarm.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

//- (void) startFlashingloc_home
//{
//    if (move_home_flag) return;
//    move_home_flag = YES;
//    
//    self.move_home.alpha = 1.0f;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionRepeat |
//     UIViewAnimationOptionAutoreverse |
//     UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         self.move_home.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) startFlashingloc_store
//{
//    if (move_store_flag) return;
//    move_store_flag = YES;
//    
//    self.move_store.alpha = 1.0f;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionRepeat |
//     UIViewAnimationOptionAutoreverse |
//     UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         self.move_store.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) startFlashingloc_station1
//{
//    if (move_st1_flag) return;
//    move_st1_flag = YES;
//    
//    self.move_st1.alpha = 1.0f;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionRepeat |
//     UIViewAnimationOptionAutoreverse |
//     UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         self.move_st1.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}

//- (void) startFlashingloc_station2
//{
//    if (move_st2_flag) return;
//    move_st2_flag = YES;
//    
//    self.move_st2.alpha = 1.0f;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionRepeat |
//     UIViewAnimationOptionAutoreverse |
//     UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         self.move_st2.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) startFlashingloc_station3
//{
//    if (move_st3_flag) return;
//    move_st3_flag = YES;
//    
//    self.move_st3.alpha = 1.0f;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionRepeat |
//     UIViewAnimationOptionAutoreverse |
//     UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         self.move_st3.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) startFlashingloc_station4
//{
//    if (move_st4_flag) return;
//    move_st4_flag = YES;
//    
//    self.move_st4.alpha = 1.0f;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionRepeat |
//     UIViewAnimationOptionAutoreverse |
//     UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         self.move_st4.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) startFlashingloc_station5
//{
//    if (move_st5_flag) return;
//    move_st5_flag = YES;
//    
//    self.move_st5.alpha = 1.0f;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionRepeat |
//     UIViewAnimationOptionAutoreverse |
//     UIViewAnimationOptionAllowUserInteraction
//                     animations:^{
//                         self.move_st5.alpha = 0.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
- (void) startFlashing_home
{
    if (home_flag) return;
    home_flag = YES;
    
    self.home.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.home.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}
//

- (void) startFlashing_store
{
    if (store_flag) return;
    store_flag = YES;
    
    self.store.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.store.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}
//
//
- (void) startFlashing_station1
{
    if (st1_flag) return;
    st1_flag = YES;
    
    self.station1.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.station1.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}
//
//
- (void) startFlashing_station2
{
    if (st2_flag) return;
    st2_flag = YES;
    
    self.station2.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.station2.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) startFlashing_station3
{
    if (st3_flag) return;
    st3_flag = YES;
    
    self.station3.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.station3.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) startFlashing_station4
{
    if (st4_flag) return;
    st4_flag = YES;
    
    self.station4.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.station4.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) startFlashing_station5
{
    if (st5_flag) return;
    st5_flag = YES;
    
    self.station5.alpha = 1.0f;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionRepeat |
     UIViewAnimationOptionAutoreverse |
     UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.station5.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_running
{
    if (!buttonFlashing_run) return;
    buttonFlashing_run = NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.agvStatus_running.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_home
{
    if (!home_flag) return;
    home_flag= NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.home.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}
- (void) stopFlashingbutton_store
{
    if (!store_flag) return;
    store_flag= NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.store.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_st1
{
    if (!st1_flag) return;
    st1_flag= NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.station1.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_st2
{
    if (!st2_flag) return;
    st2_flag= NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.station2.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_st3
{
    if (!st3_flag) return;
    st3_flag= NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.station3.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_st4
{
    if (!st4_flag) return;
    st4_flag= NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.station4.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_st5
{
    if (!st5_flag) return;
    st5_flag= NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.station5.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}
//
//- (void) stopFlashingloc_home
//{
//    if (!move_home_flag) return;
//    move_home_flag = NO;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.move_home.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) stopFlashingloc_store
//{
//    if (!move_store_flag) return;
//    move_store_flag = NO;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.move_store.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) stopFlashingloc_station1
//{
//    if (!move_st1_flag) return;
//    move_st1_flag = NO;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.move_st1.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) stopFlashingloc_station2
//{
//    if (!move_st2_flag) return;
//    move_st2_flag = NO;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.move_st2.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) stopFlashingloc_station3
//{
//    if (!move_st3_flag) return;
//    move_st3_flag = NO;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.move_st3.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
//- (void) stopFlashingloc_station4
//{
//    if (!move_st4_flag) return;
//    move_st4_flag = NO;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.move_st4.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}

//- (void) stopFlashingloc_station5
//{
//    if (!move_st5_flag) return;
//    move_st5_flag = NO;
//    [UIView animateWithDuration:0.50
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut |
//     UIViewAnimationOptionBeginFromCurrentState
//                     animations:^{
//                         self.move_st5.alpha = 1.0f;
//                     }
//                     completion:^(BOOL finished){
//                         // Do nothing
//                     }];
//}
//
- (void) stopFlashingbutton_stopped
{
    if (!buttonFlashing_stop) return;
    buttonFlashing_stop = NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.agvStatus_stopped.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}

- (void) stopFlashingbutton_alarm
{
    if (!buttonFlashing_alarm) return;
    buttonFlashing_alarm = NO;
    [UIView animateWithDuration:0.50
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut |
     UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.agvStatus_alarm.alpha = 1.0f;
                     }
                     completion:^(BOOL finished){
                         // Do nothing
                     }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static   NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
    }
    
    AppDelegate *appdelegate =   [[UIApplication sharedApplication] delegate];

    MaterialList *ml =  [appdelegate.materialList objectAtIndex:indexPath.row];
//
    UIImage *myImage = [UIImage imageNamed:@"cell_row.png"];
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:myImage] init];
    imageView.frame = CGRectMake(0,0,1024,54);
//

    UILabel *lblTitle_materialID = [[UILabel alloc] initWithFrame:CGRectMake(80,13, 100 ,30)];
    lblTitle_materialID.text = ml.materialID;
    lblTitle_materialID.textColor = [UIColor colorWithRed:(133.0f/255.0f) green:(133.0f/255.0f) blue:(133.0f/255.0f) alpha:1.0];
    
    lblTitle_materialID.font = [UIFont fontWithName:@"Helvetica" size:18];
    [imageView addSubview:lblTitle_materialID];


    UILabel *lblTitle_quantity = [[UILabel alloc] initWithFrame:CGRectMake(250,13,100,30)];
    lblTitle_quantity.text = ml.quantity;
    lblTitle_quantity.textColor = [UIColor colorWithRed:(133.0f/255.0f) green:(133.0f/255.0f) blue:(133.0f/255.0f) alpha:1.0];
    lblTitle_quantity.font = [UIFont fontWithName:@"Helvetica" size:18];
    [imageView addSubview:lblTitle_quantity];

    
    UILabel *lblTitle_availability = [[UILabel alloc] initWithFrame:CGRectMake(450,13, 100 ,30)];
    lblTitle_availability.text = ml.availability;
    lblTitle_availability.textColor = [UIColor colorWithRed:(133.0f/255.0f) green:(133.0f/255.0f) blue:(133.0f/255.0f) alpha:1.0];
    lblTitle_availability.font = [UIFont fontWithName:@"Helvetica" size:18];
    [imageView addSubview:lblTitle_availability];

    
    UILabel *lblTitle_stationNo = [[UILabel alloc] initWithFrame:CGRectMake(650,13, 100 ,30)];
    lblTitle_stationNo.text = ml.station;
    lblTitle_stationNo.textColor = [UIColor colorWithRed:(133.0f/255.0f) green:(133.0f/255.0f) blue:(133.0f/255.0f) alpha:1.0];
    lblTitle_stationNo.font = [UIFont fontWithName:@"Helvetica" size:18];
    [imageView addSubview:lblTitle_stationNo];

    
    UILabel *lblTitle_delivery = [[UILabel alloc] initWithFrame:CGRectMake(850,13, 100 ,30)];
    lblTitle_delivery.text = ml.delivery;
    lblTitle_delivery.textColor = [UIColor colorWithRed:(133.0f/255.0f) green:(133.0f/255.0f) blue:(133.0f/255.0f) alpha:1.0];
    lblTitle_delivery.font = [UIFont fontWithName:@"Helvetica" size:18];
    [imageView addSubview:lblTitle_delivery];
    
    cell.backgroundView = imageView;
    
    CAShapeLayer *shapelayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    //draw a line
    [path moveToPoint:CGPointMake(0.0, cell.frame.size.height)]; //add yourStartPoint here
    [path addLineToPoint:CGPointMake(cell.frame.size.width, cell.frame.size.height)];// add yourEndPoint here
    UIColor *fill = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
    shapelayer.strokeStart = 0.0;
    shapelayer.strokeColor = fill.CGColor;
    shapelayer.lineWidth = 1.0;
    shapelayer.lineJoin = kCALineJoinRound;
    shapelayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:3 ], nil];
    //    shapelayer.lineDashPhase = 3.0f;
    shapelayer.path = path.CGPath;
    
    [cell.contentView.layer addSublayer:shapelayer];
    
    // Configure Cell
//    [cell.textLabel setText:[NSString stringWithFormat:@"Row %i in Section %i", [indexPath row], [indexPath section]]];
    
    return cell;
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
