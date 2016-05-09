//
//  TagListView.h
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"
#import "TagResultView.h"

@interface TagListView : UIViewController{
    
}

@property (strong, nonatomic) UINavigationBar *tagsViewNav;
@property (strong, nonatomic) UILabel *navLabel;


//ナビゲーション下部に付いているセグメントバー,selectedSegmentIndexが0は化学式,selectedSegmentIndexが1は化合物
@property (strong, nonatomic) UISegmentedControl *tableSegment;


//官能基情報
@property (strong, nonatomic) NSArray *functionalGroupPlist;

//反応に関するタグ
@property (strong, nonatomic) NSArray *reactionTagPlist;

@property (strong, nonatomic) TagView *listViews;


@property (strong, nonatomic) UIScrollView *sv;

@end
