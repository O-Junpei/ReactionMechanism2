//
//  TagListView.m
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import "TagListView.h"

@interface TagListView (){

}

@end

@implementation TagListView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //官能基plistの読み込み
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    //読み込むプロパティリストのファイルパスを指定
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"functionalGroup" ofType:@"plist"];
    
    //プロパティリストの中身データを取得
    _functionalGroupPlist = [NSArray arrayWithContentsOfFile:path];
    
    path = [bundle pathForResource:@"reactionTag" ofType:@"plist"];
    
    _reactionTagPlist = [NSArray arrayWithContentsOfFile:path];
    
    
    //初回は「functional」の方を表示する
    _functionTagFlug = @"functionalGroup";
    
    
    //背景色の設定
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    //view上部のナビゲーションバーの設定
    _tagsViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _tagsViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    _tagsViewNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:self.tagsViewNav];
    
    
    // ナビゲーションアイテムを生成
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *changeTagBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"changeIcon_40.png"] style:UIBarButtonItemStylePlain target:self action:@selector(changeTag:)];
    
    
    // ナビゲーションアイテムにタグの切り替えボタンの変更
    navItem.rightBarButtonItem = changeTagBtn;
    
    
    //タグ切り替えボタンの色の変更
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [_tagsViewNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:self.tagsViewNav];
    
    
    //ナビゲーションバーに設置したラベルの設定
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.navLabel.text = @"Tag List";
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.navLabel];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    //Viewにセットする
    [self setScrollAndTagView];
}


#pragma mark --UIViewにScrollViewとTagViewを設置
-(void)setScrollAndTagView{
    
#pragma mark --スクロールビュー
    // スクロールビュー例文
    _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _sv.backgroundColor = [UIColor whiteColor];
    
    //一つのViewの大きさ
    float listViewWidth = self.view.frame.size.width * 0.28;
    
    //スペーサーの大きさ
    float spaceWidth = self.view.frame.size.width * 0.04;
    
    
    //表示個数
    int Viewkazu;
    
    if ([_functionTagFlug isEqualToString:@"functionalGroup"]) {
        
        NSLog(@"yes");
        Viewkazu = (int)[_functionalGroupPlist count];
    }else{
        NSLog(@"no");
        Viewkazu = (int)[_reactionTagPlist count];
    }
    

    //表示個数
    //int Viewkazu = (int)[_functionalGroupPlist count];
    
    float uvHeight = spaceWidth + (spaceWidth + listViewWidth*1.5)*(Viewkazu/3) + 50;
    
    
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, uvHeight)];
    uv.backgroundColor = [UIColor whiteColor];
    
    
    //タッチイベントの有効化
    
    _listViews.userInteractionEnabled = true;
    
    for (int i=0; i < Viewkazu; i++) {
        
        float viewHeight = spaceWidth + (spaceWidth + listViewWidth*1.5)*(i/3);
        
        switch (i%3)
        {
            case 0:
                //
                _listViews = [[TagView alloc] initWithFrame:CGRectMake(spaceWidth, viewHeight, listViewWidth, listViewWidth*1.5)];
                break;
            case 1:
                
                _listViews = [[TagView alloc] initWithFrame:CGRectMake(spaceWidth*2+listViewWidth, viewHeight, listViewWidth, listViewWidth*1.5)];
                break;
                
            case 2:
                _listViews = [[TagView alloc] initWithFrame:CGRectMake(spaceWidth*3+listViewWidth*2, viewHeight, listViewWidth, listViewWidth*1.5)];
                break;
            default:
                NSLog(@"Error");
                break;
        }
        
        _listViews.userInteractionEnabled = true;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hoge:)];
        [_listViews addGestureRecognizer:tapGesture];
        
        
        _listViews.tag = i;
        [uv addSubview:_listViews];
        
        
        NSString *id;
        id = ([_functionTagFlug isEqualToString:@"functionalGroup"])?([[_functionalGroupPlist objectAtIndex:i] valueForKey:@"id"]):([[_reactionTagPlist objectAtIndex:i] valueForKey:@"id"]);

        _listViews.TagImage.image = [UIImage imageNamed:id];

        
        NSString *lang;
        lang = ([ReactionLibrary isEnglish])?(@"ename"):(@"jname");
        
        
        _listViews.TagText.text = ([_functionTagFlug isEqualToString:@"functionalGroup"])?([[_functionalGroupPlist objectAtIndex:i] valueForKey:lang]):([[_reactionTagPlist objectAtIndex:i] valueForKey:lang]);
        

    }
    
    
    [_sv addSubview:uv];
    
    CGSize sz = CGSizeMake(uv.bounds.size.width, uv.bounds.size.height+_listViews.frame.size.height*1.1);
    
    _sv.contentSize = sz;
    
    [self.view addSubview:_sv];
}





-(void)hoge:(id)sender
{
    int selectedViewTag = (int)[(UIGestureRecognizer *)sender view].tag;
    
    //詳細表示画面にidを送る
    TagResultView *secondVC = [[TagResultView alloc] init];
    
    
    NSDictionary *dic;
    if ([_functionTagFlug isEqualToString:@"functionalGroup"])
    {
        dic = [_functionalGroupPlist objectAtIndex:selectedViewTag];
    }
    else
    {
        dic = [_reactionTagPlist objectAtIndex:selectedViewTag];
    }
    
    
    
    
    
    secondVC.tagID = [dic objectForKey:@"id"];
    //secondVC.selectedID = selectedID;
    [self presentViewController: secondVC animated:YES completion: nil];
}


#pragma mark --ナビゲーションボタン右上の虫眼鏡が押されたら動く
- (void)changeTag:(UIButton *)btn {
    
    _functionTagFlug = ([_functionTagFlug isEqualToString:@"functionalGroup"])?(@"reactionTag"):(@"functionalGroup");
    
    [self setScrollAndTagView];
}

@end
