//
//  ConfigView.h
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCLAlertView.h"
@interface ConfigView : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    
}

//view
@property (strong, nonatomic) UINavigationBar *configViewNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) UITableView *configTableView;

@end
