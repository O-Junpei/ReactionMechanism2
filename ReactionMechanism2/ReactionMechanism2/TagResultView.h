//
//  TagResultView.h
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/04/13.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"
#import "ReactionLibrary.h"

@interface TagResultView : UIViewController<UITableViewDelegate,UITableViewDataSource>


//View関連
@property (strong, nonatomic) UINavigationBar *tagResultNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) UITableView *listTableView;
@property (strong, nonatomic) NSMutableArray *tableViewAry;

//選択されたtagID
@property (strong, nonatomic) NSString *tagID;
@property (strong, nonatomic) NSArray *sciencePlist;


@end
