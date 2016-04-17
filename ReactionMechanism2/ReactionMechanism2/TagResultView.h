//
//  TagResultView.h
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/04/13.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"

@interface TagResultView : UIViewController<UITableViewDelegate,UITableViewDataSource>



@property (strong, nonatomic) UINavigationBar *tagResultNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) NSString *tagID;
@property (strong, nonatomic) NSArray *sciencePlist;
@property (strong, nonatomic) NSMutableArray *tableViewAry;

@end
