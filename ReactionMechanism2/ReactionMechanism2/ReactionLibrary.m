//
//  ReactionLibrary.m
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/05/08.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import "ReactionLibrary.h"

@implementation ReactionLibrary

#pragma mark --jsonから作った配列を引数に応じて返す
+(BOOL)isEnglish{
    
    NSUserDefaults *myDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isEnglish;
    isEnglish = ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"english"])?(YES):(NO);
    
    return isEnglish;
}
@end
