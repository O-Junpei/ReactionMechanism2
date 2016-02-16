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
    
    
    
    
    //背景色の設定
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    
    //view上部のナビゲーションバーの設定
    self.tagsViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.tagsViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    self.tagsViewNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:self.tagsViewNav];
    
    
    // ナビゲーションアイテムを生成
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *changeTagBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(changeTag:)];
    
    
    // ナビゲーションアイテムにタグの切り替えボタンの変更
    navItem.rightBarButtonItem = changeTagBtn;
    
    //タグ切り替えボタンの色の変更
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [self.tagsViewNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:self.tagsViewNav];
    
    
    //ナビゲーションバーに設置したラベルの設定
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.navLabel.text = @"Tag List";
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.navLabel];
    
    
    
    
    /*
    NSArray *segmentAry = [NSArray arrayWithObjects:@"化学式", @"化合物", nil];
    self.tableSegment = [[UISegmentedControl alloc] initWithItems:segmentAry];
    self.tableSegment.frame = CGRectMake(40, 66, self.view.frame.size.width-80, 24);
    self.tableSegment.selectedSegmentIndex = 0; //化学式を選択
    
    //値が変更された時にsegmentChangedメソッドを呼び出す
    [self.tableSegment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.tableSegment];*/
    
    
#pragma mark --スクロールビュー
    // スクロールビュー例文
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    sv.backgroundColor = [UIColor whiteColor];
    
    
    
    
    //一つのViewの大きさ
    float listViewWidth = self.view.frame.size.width * 0.28;
    
    //スペーサーの大きさ
    float spaceWidth = self.view.frame.size.width * 0.04;
    
    //表示個数
    int Viewkazu = 15;
    
    float uvHeight = spaceWidth + (spaceWidth + listViewWidth*1.5)*(Viewkazu/3) + 50;
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, uvHeight)];
    uv.backgroundColor = [UIColor whiteColor];
    

    
    
    for (int i=0; i < Viewkazu; i++) {
        
        UIView *listViews;
        float viewHeight = spaceWidth + (spaceWidth + listViewWidth*1.5)*(i/3);
        
        switch (i%3) {
            case 0:
                //
                listViews = [[UIView alloc] initWithFrame:CGRectMake(spaceWidth, viewHeight, listViewWidth, listViewWidth*1.5)];
                [uv addSubview:listViews];
                break;
            case 1:
                
                listViews = [[UIView alloc] initWithFrame:CGRectMake(spaceWidth*2+listViewWidth, viewHeight, listViewWidth, listViewWidth*1.5)];
                [uv addSubview:listViews];
                break;
                
            case 2:
                listViews = [[UIView alloc] initWithFrame:CGRectMake(spaceWidth*3+listViewWidth*2, viewHeight, listViewWidth, listViewWidth*1.5)];
                [uv addSubview:listViews];
                
                break;
                
                
            default:
                break;
        }
        listViews.backgroundColor = [UIColor greenColor];

    }
    
    
    
    
    /*
    
    
    
    
    UIView *test2 = [[UIView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/12)*(7/12), self.view.frame.size.width/12, self.view.frame.size.width/3, 250)];
    test2.backgroundColor = [UIColor yellowColor];
    
    
    [uv addSubview:test2];
    [uv addSubview:test1];
    
    */

    [sv addSubview:uv];
    sv.contentSize = uv.bounds.size;
    [self.view addSubview:sv];
    
}


#pragma mark --ナビゲーションボタン右上の虫眼鏡が押されたら動く
- (void)changeTag:(UIButton *)btn {
    
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
