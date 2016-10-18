//
//  ConfigView.h
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

@import GoogleMobileAds;

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "SCLAlertView.h"
#import "AAShareBubbles.h"
#import "ReactionSettings.h"
#import "ReactionLibrary.h"
@interface ConfigView : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,AAShareBubblesDelegate>{
    
    //広告
    GADBannerView *bannerView_;
}

//view
@property (strong, nonatomic) UINavigationBar *configViewNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) UITableView *configTableView;

@end
