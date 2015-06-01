//
//  DashboardViewController.h
//  jcivwp
//
//  Created by 179159 on 18/05/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) IBOutlet UILabel *alarmText;
@property(nonatomic,strong) IBOutlet UITableView *materialTable;

@property(nonatomic,strong) IBOutlet UIButton *agvStatus_running;
@property(nonatomic,strong) IBOutlet UIButton *agvStatus_stopped;
@property(nonatomic,strong) IBOutlet UIButton *agvStatus_alarm;

@property(nonatomic,strong) IBOutlet UIButton *station1;
@property(nonatomic,strong) IBOutlet UIButton *station2;
@property(nonatomic,strong) IBOutlet UIButton *station3;
@property(nonatomic,strong) IBOutlet UIButton *station4;
@property(nonatomic,strong) IBOutlet UIButton *station5;
@property(nonatomic,strong) IBOutlet UIButton *store;
@property(nonatomic,strong) IBOutlet UIButton *home;

@property(nonatomic,strong) IBOutlet UIButton *move_home;
@property(nonatomic,strong) IBOutlet UIButton *move_store;
@property(nonatomic,strong) IBOutlet UIButton *move_st1;
@property(nonatomic,strong) IBOutlet UIButton *move_st2;
@property(nonatomic,strong) IBOutlet UIButton *move_st3;
@property(nonatomic,strong) IBOutlet UIButton *move_st4;
@property(nonatomic,strong) IBOutlet UIButton *move_st5;

@property (assign) BOOL buttonFlashing_run;
@property (assign) BOOL buttonFlashing_stop;
@property (assign) BOOL buttonFlashing_alarm;


//@property(assign) BOOL move_home_flag;
//@property(assign) BOOL move_store_flag;
//@property(assign) BOOL move_st1_flag;
//@property(assign) BOOL move_st2_flag;
//@property(assign) BOOL move_st3_flag;
//@property(assign) BOOL move_st4_flag;
//@property(assign) BOOL move_st5_flag;


@property(assign) BOOL home_flag;
@property(assign) BOOL store_flag;
@property(assign) BOOL st1_flag;
@property(assign) BOOL st2_flag;
@property(assign) BOOL st3_flag;
@property(assign) BOOL st4_flag;
@property(assign) BOOL st5_flag;

//@property (nonatomic, strong) IBOutlet UIButton *direct_8;
//@property (nonatomic, strong) IBOutlet UIButton *direct_9;
//@property (nonatomic, strong) IBOutlet UIButton *direct_14;
//@property (nonatomic, strong) IBOutlet UIButton *direct_19;
//@property (nonatomic, strong) IBOutlet UIButton *direct_23;
//@property (nonatomic, strong) IBOutlet UIButton *direct_26;
//@property (nonatomic, strong) IBOutlet UIButton *direct_28;
//
//
//@property (nonatomic, strong) IBOutlet UIButton *direct_10;
//@property (nonatomic, strong) IBOutlet UIButton *direct_11;
//@property (nonatomic, strong) IBOutlet UIButton *direct_12;
//@property (nonatomic, strong) IBOutlet UIButton *direct_13;
//
//@property (nonatomic, strong) IBOutlet UIButton *direct_15;
//@property (nonatomic, strong) IBOutlet UIButton *direct_16;
//@property (nonatomic, strong) IBOutlet UIButton *direct_17;
//@property (nonatomic, strong) IBOutlet UIButton *direct_18;
//@property (nonatomic, strong) IBOutlet UIButton *direct_20;
//@property (nonatomic, strong) IBOutlet UIButton *direct_21;
//@property (nonatomic, strong) IBOutlet UIButton *direct_22;
//@property (nonatomic, strong) IBOutlet UIButton *direct_24;
//@property (nonatomic, strong) IBOutlet UIButton *direct_25;
//@property (nonatomic, strong) IBOutlet UIButton *direct_27;

@property(nonatomic,strong) IBOutlet UIButton *status_run;
@property(nonatomic,strong) IBOutlet UIButton *status_stop;
@property(nonatomic,strong) IBOutlet UIButton *status_alarm;

@property(nonatomic,strong) IBOutlet UIImageView *dashLine;



- (void)parseResponse;

- (IBAction)logout:(id)sender;

@end
