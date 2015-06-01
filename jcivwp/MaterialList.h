//
//  MaterialList.h
//  jcivwp
//
//  Created by 179159 on 20/05/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MaterialList : NSObject

@property(nonatomic,strong) NSString *materialID;
@property(nonatomic,strong) NSString *quantity;
@property(nonatomic,strong) NSString *station;
@property(nonatomic,strong) NSString *availability;
@property(nonatomic,strong) NSString *delivery;

@end
