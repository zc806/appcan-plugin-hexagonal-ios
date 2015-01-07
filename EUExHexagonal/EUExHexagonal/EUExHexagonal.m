//
//  EUExAppCenterMgr.m
//  AppCan
//
//  Created by AppCan on 11-10-19.
//  Copyright 2011 AppCan. All rights reserved.
//

#import "EUExHexagonal.h"
#import "EUtility.h"
#import "JSON.h"

@implementation EUExHexagonal
@synthesize navigationView;
@synthesize jsonDict;

-(id)initWithBrwView:(EBrowserView *) eInBrwView{
	if (self = [super initWithBrwView:eInBrwView]) {
        
    }
    return self;
}

-(void)open:(NSMutableArray *)inArguments{
    if (inArguments!=nil && [inArguments count]==4) {
        int inX = [[inArguments objectAtIndex:0] intValue];
        int inY = [[inArguments objectAtIndex:1] intValue];
        int inWidth = [[inArguments objectAtIndex:2] intValue];
        int inHeight = [[inArguments objectAtIndex:3] intValue];
        
        if (navigationView == nil) {
            navigationView = [[EUExNavigationView alloc] initWithFrame:CGRectMake(inX+(inWidth-320)/2.0, inY+(inHeight-320)/2.0, 320, 320) jsonDict:jsonDict EUExHexagonal:self];
            [EUtility brwView:self.meBrwView addSubview:navigationView];
        }
    }
}

-(void)setPrismParam:(NSMutableArray *)array{
    if ([array isKindOfClass:[NSMutableArray class]] && [array count]>0) {
        NSString *jsonData = [array objectAtIndex:0];
        self.jsonDict = [jsonData JSONValue];
    }
}

-(void)naviClicked:(NSNumber*)index{
    NSString *jsString = [NSString stringWithFormat:@"uexHexagonal.naviClicked(\"%@\");",index];
    [self.meBrwView stringByEvaluatingJavaScriptFromString:jsString];
    
    NSString *jsStringOn = [NSString stringWithFormat:@"uexHexagonal.onItemClick(\"%@\");",index];
    [self.meBrwView stringByEvaluatingJavaScriptFromString:jsStringOn];
}

-(void)close:(NSMutableArray *)inArguments{
    if (navigationView) {
        [navigationView removeFromSuperview];
        self.navigationView=nil;
    }
    if (jsonDict) {
        self.jsonDict=nil;
    }
}

-(void)clean{
    if (navigationView) {
        [navigationView removeFromSuperview];
        self.navigationView=nil;
    }
    if (jsonDict) {
        self.jsonDict=nil;
    }
}

-(void)dealloc{
    if (navigationView) {
        [navigationView removeFromSuperview];
        self.navigationView=nil;
    }
    if (jsonDict) {
        self.jsonDict=nil;
    }
    [super dealloc];
}

@end
