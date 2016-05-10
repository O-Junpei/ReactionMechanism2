//
//  TagListView.h
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagResultView.h"
#import "TagView.h"
#import "ReactionLibrary.h"

@interface TagListView : UIViewController{
    
}

//view
@property (strong, nonatomic) UINavigationBar *tagsViewNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) TagView *listViews;
@property (strong, nonatomic) UIScrollView *sv;

//官能基情報
@property (strong, nonatomic) NSArray *functionalGroupPlist;

//反応に関するタグ
@property (strong, nonatomic) NSArray *reactionTagPlist;

//「function、「Tag」、どちらを表示しているか判別するためのフラグ
@property (strong, nonatomic) NSString *functionTagFlug;

@end
