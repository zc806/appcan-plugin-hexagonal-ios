//
//  LEAppCenterView.h
//  AppCan
//
//  Created by AppCan on 12-12-12.
//  Copyright (c) 2012年 AppCan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUtility.h"

@class EUExHexagonal;
@interface EUExNavigationView : UIView{
    BOOL isSetPrismParam;
}

@property(nonatomic,assign)EUExHexagonal* eUExNavigation;

-(id)initWithFrame:(CGRect)frame jsonDict:(NSMutableDictionary *)jsonDict EUExHexagonal:(EUExHexagonal *)uexBase;

@end
