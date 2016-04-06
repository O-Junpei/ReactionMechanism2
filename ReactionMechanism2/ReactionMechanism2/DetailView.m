//
//  DetailView.m
//  
//
//  Created by onojunpei on 2016/03/26.
//
//

#import "DetailView.h"

@interface DetailView (){
    NSUserDefaults *myDefaults;
}

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"DetailViewに遷移したよ");
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
#pragma mark --UserDefaultの初期化
    //UserDefaultsの初期設定
    myDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:@"english" forKey:@"KEY_Language"];  // をKEY_Iというキーの初期値は99
    [myDefaults registerDefaults:defaults];
    
#pragma mark --plistの読み込み
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    //読み込むプロパティリストのファイルパスを指定
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sciecePlist" ofType:@"plist"];
    //プロパティリストの中身データを取得
    _sciencePlist = [NSArray arrayWithContentsOfFile:path];
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"id", self.selectedID];
    NSDictionary *resultDic = [[_sciencePlist filteredArrayUsingPredicate:predicate] firstObject];
    NSLog(@"results:%@", resultDic);
    
    
    NSString *labelText;
    
    if ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"japanise"]) {
        labelText = [resultDic valueForKey:@"jname"];
    }else{
        labelText = [resultDic valueForKey:@"ename"];
    }
    
    
    
#pragma mark --ナビゲーションバーの設定
    
    //背景色の設定
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    //view上部のナビゲーションバーの設定
    self.detailViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.detailViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    self.detailViewNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:self.detailViewNav];
    
    // ナビゲーションアイテムを生成
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *backNavBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backView:)];
    
    
    // ナビゲーションアイテムに戻るボタンを設置
    navItem.leftBarButtonItem = backNavBtn;
    
    //虫めがねの色の変更
    navItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [self.detailViewNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:self.detailViewNav];
    
    
    //ナビゲーションバーに設置したラベルの設定
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, self.view.frame.size.width-100, 44)];
    self.navLabel.numberOfLines = 2;
    self.navLabel.text = labelText;
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.navLabel];
}


#pragma mark --前のViewに戻る
- (void)backView:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark --StatusBarを白色に
- (UIStatusBarStyle)preferredStatusBarStyle {
    //文字を白くする
    return UIStatusBarStyleLightContent;
}



@end
