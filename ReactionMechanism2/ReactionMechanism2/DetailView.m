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
    NSDictionary *resultDic;
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
    
    //欲しい配列を取得する
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"id", self.selectedID];
    resultDic = [[_sciencePlist filteredArrayUsingPredicate:predicate] firstObject];
    NSLog(@"results:%@", resultDic);
    

    //ナビゲーションバーのセット
    [self setNavBar];
    
    [self setScrView];
    
}



#pragma mark --ナビゲーションバーをセットする
- (void)setNavBar{
    
    //ナビゲーションバーの設定
    
    NSString *labelText;
    
    if ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"japanise"]) {
        labelText = [resultDic valueForKey:@"jname"];
    }else{
        labelText = [resultDic valueForKey:@"ename"];
    }
    
    
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




#pragma mark --スクリールビューのセット
- (void)setScrView{
    //スクリールビュ
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    sv.backgroundColor = [UIColor blackColor];
    sv.maximumZoomScale = 2.5;
    sv.minimumZoomScale = 1.0;
    sv.delegate = self;
    
    iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    //日本語か英語かで表示画像を切り替える
    NSString *fileName;
    if ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"japanise"]) {
        fileName = [self.selectedID stringByAppendingString:@"_jname.png"];
    }else{
        fileName = [self.selectedID stringByAppendingString:@"_ename.png"];
    }
    
    UIImage *img = [UIImage imageNamed:fileName];
    iv.image = img;
    [sv addSubview:iv];

    [self.view addSubview:sv];
}


#pragma mark --ScrillViewのデリゲートメソッド
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return iv;
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
