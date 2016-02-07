//
//  TagListView.m
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import "TagListView.h"

@interface TagListView ()

@end

@implementation TagListView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    
    //view上部のナビゲーションバーの設定
    self.tagsViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 88)];
    self.tagsViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    self.tagsViewNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:self.tagsViewNav];
    
    /*
    // ナビゲーションアイテムを生成
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *serchNavBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar:)];
    
    
    // ナビゲーションアイテムに戻る、サーチボタンを設置
    navItem.rightBarButtonItem = serchNavBtn;
    
    //虫めがねの色の変更
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [self.tagsViewNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:self.tagsViewNav];
    */
    
    //ナビゲーションバーに設置したラベルの設定
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.navLabel.text = @"Tag List";
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.navLabel];
    
    
    
#pragma mark --「化学式」と「化合物」のセグメント
    
    NSArray *segmentAry = [NSArray arrayWithObjects:@"化学式", @"化合物", nil];
    self.tableSegment = [[UISegmentedControl alloc] initWithItems:segmentAry];
    self.tableSegment.frame = CGRectMake(40, 66, self.view.frame.size.width-80, 24);
    self.tableSegment.selectedSegmentIndex = 0; //化学式を選択
    
    //値が変更された時にsegmentChangedメソッドを呼び出す
    [self.tableSegment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.tableSegment];
    
    
    
    // スクロールビュー例文
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 108, self.view.frame.size.width, self.view.frame.size.height-49-44)];
    sv.backgroundColor = [UIColor whiteColor];
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1000)];
    uv.backgroundColor = [UIColor whiteColor];
    
    
    //
    UIView *test1 = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/12, self.view.frame.size.width/12, self.view.frame.size.width/3, 250)];
    test1.backgroundColor = [UIColor greenColor];
    
    UIView *test2 = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/12)*(7/12), self.view.frame.size.width/12, self.view.frame.size.width/3, 250)];
    test2.backgroundColor = [UIColor yellowColor];
    
    
    [uv addSubview:test2];
    [uv addSubview:test1];
    
    

    [sv addSubview:uv];
    sv.contentSize = uv.bounds.size;
    [self.view addSubview:sv];
    
}


#pragma mark --StatusBarを白色に
- (UIStatusBarStyle)preferredStatusBarStyle {
    //文字を白くする
    return UIStatusBarStyleLightContent;
}


#pragma mark --セグメントが変更された時に呼ばれる
-(void)segmentChanged:(UISegmentedControl*)seg{
    

}


@end
