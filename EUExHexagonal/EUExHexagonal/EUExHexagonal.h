//
//  EUExNavigation.h
//  AppCan
//
//  Created by AppCan on 11-10-19.
//  Copyright 2011 AppCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EUExBase.h"
#import "EUExNavigationView.h"

@interface EUExHexagonal : EUExBase {
	
}

@property(nonatomic,retain)EUExNavigationView *navigationView;
@property(nonatomic,retain)NSMutableDictionary *jsonDict;

-(void)naviClicked:(NSNumber*)index;

@end
