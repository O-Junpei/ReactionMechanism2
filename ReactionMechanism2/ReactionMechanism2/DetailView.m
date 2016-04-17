//
//  DetailView.m
//  
//
//  Created by onojunpei on 2016/03/26.
//
//

#import "DetailView.h"

#define CUSTOM_BUTTON_ID_LINE 100


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
    UIBarButtonItem *serchNavBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareApp:)];
    
    // ナビゲーションアイテムに戻るボタンを設置
    navItem.leftBarButtonItem = backNavBtn;
    navItem.rightBarButtonItem = serchNavBtn;
    
    //アイテムの色の変更
    navItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    
    
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

#pragma mark --アプリをシェアする
- (void)shareApp:(UIButton *)btn {
    
    //拡散用シェアバブルを開く
    [self showShareBubles];

}

#pragma mark - 各種拡散系
#pragma mark --ShareBubleで拡散する
- (void) showShareBubles{
    
    float radius=140;
    float bubbleRadius=35;
    
    AAShareBubbles *shareBubbles = [[AAShareBubbles alloc] initWithPoint:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)
                                                                  radius:radius
                                                                  inView:self.view];
    
    
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = bubbleRadius; // Default is 40
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showMailBubble = YES;
    
    // add custom buttons -- buttonId for custom buttons MUST be greater than or equal to 100
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"lineCustumIcon"]
                          backgroundColor:[UIColor colorWithRed:(float)27/255 green:(float)183/255 blue:(float)31/255 alpha:1.0]
                              andButtonId:CUSTOM_BUTTON_ID_LINE];
    
    [shareBubbles show];
}


#pragma mark --ShareBubleのボタンが押されたときに動く
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(int)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:
            //NSLog(@"Facebook");
            [self spreadOnFaceBook];
            break;
        case AAShareBubbleTypeTwitter:
            //NSLog(@"Twitter");
            [self spreadOnTwitter];
            break;
        case AAShareBubbleTypeMail:
            [self spreadOnMail];
            break;
        case AAShareBubbleTypeGooglePlus:
            NSLog(@"Google+");
            break;
        case AAShareBubbleTypeTumblr:
            NSLog(@"Tumblr");
            break;
        case AAShareBubbleTypeVk:
            NSLog(@"Vkontakte (vk.com)");
            break;
        case AAShareBubbleTypeLinkedIn:
            NSLog(@"LinkedIn");
            break;
        case AAShareBubbleTypeYoutube:
            NSLog(@"Youtube");
            break;
        case AAShareBubbleTypeVimeo:
            NSLog(@"Vimeo");
            break;
        case AAShareBubbleTypeReddit:
            NSLog(@"Reddit");
            break;
        case CUSTOM_BUTTON_ID_LINE:
            //NSLog(@"LINE With Type %d ", bubbleType);
            [self spreadOnLINE];
            break;
        default:
            break;
    }
}



#pragma mark --ShareBubleが消えたときに動く
-(void)aaShareBubblesDidHide:(AAShareBubbles*)bubbles
{
    NSLog(@"All Bubbles hidden");
}


#pragma mark --Twitterで拡散する
- (void) spreadOnTwitter
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]){
        //ツイッター拡散用
        SLComposeViewController *twitterVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitterVc setInitialText:@"クイズで化学が勉強できる〜４択化学〜　　#四択化学"];
        [twitterVc addURL:[NSURL URLWithString:@"http://conol.co.jp/apps/chemist/"]];
        [self presentViewController:twitterVc animated:YES completion:nil];
    }else{
        [self shareFailAlart:@"投稿失敗しました" message:@"Twitterアプリをインストール後に拡散機能をお使いください。"];
    }
}


#pragma mark --FaceBookで拡散する
- (void) spreadOnFaceBook
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        NSString *postContent = [NSString stringWithFormat:@"クイズで化学が勉強できる〜４択化学〜"];
        [facebookPostVC setInitialText:postContent];
        [facebookPostVC addURL:[NSURL URLWithString:@"http://conol.co.jp/apps/chemist/"]]; // URL文字列
        [self presentViewController:facebookPostVC animated:YES completion:nil];
    }else{
        [self shareFailAlart:@"投稿失敗しました" message:@"FaceBookアプリをインストール後に拡散機能をお使いください。"];
    }
}


#pragma mark --LINEで拡散する
- (void) spreadOnLINE
{
    NSString *string = [NSString stringWithFormat:@"クイズで化学が勉強できる〜４択化学〜 \nhttp://conol.co.jp/apps/chemist/"];
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *LINEUrlString = [NSString stringWithFormat:@"line://msg/text/%@", string];
    
    //LINEがインストールされているか確認。されていなければアラート
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LINEUrlString]];
    } else {
        [self shareFailAlart:@"投稿失敗しました" message:@"LINEアプリをインストール後に拡散機能をお使いください。"];
    }
}


#pragma mark --Mailで拡散する
- (void) spreadOnMail
{
    
    // メール設定が行われているか確認
    if ([MFMailComposeViewController canSendMail])
    {
        // メール設定が行われている場合
        // メールビュー生成
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        // メール件名
        [picker setSubject:@"四択化学"];
        
        // メール本文
        NSMutableString *bodytxt = [NSMutableString string];
        [bodytxt appendString:@"クイズで化学が勉強できる〜４択化学〜"];
        [bodytxt appendString:@"http://conol.co.jp/apps/chemist/"];
        
        [picker setMessageBody:bodytxt isHTML:NO];  // HTMLメールの場合は「YES」
        
        // メールビュー表示
        [self presentViewController:picker animated:YES completion:nil];
        
    }
    else
    {
        // メール設定が行われていない場合
        [self shareFailAlart:@"投稿失敗しました" message:@"Mail設定を済ませてから拡散機能をお使いください。"];
        
    }
}


#pragma mark --MailDelegateMethod
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --拡散失敗Alert
- (void)shareFailAlart:(NSString *)title message:(NSString *)text
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:text
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    // Cancel用のアクションを生成
    UIAlertAction * cancelAction =
    [UIAlertAction actionWithTitle:@"閉じる"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               // ボタンタップ時の処理
                           }];
    
    // コントローラにアクションを追加
    [alertController addAction:cancelAction];
    
    // アラート表示処理
    [self presentViewController:alertController animated:YES completion:nil];
}



#pragma mark --StatusBarを白色に
- (UIStatusBarStyle)preferredStatusBarStyle {
    //文字を白くする
    return UIStatusBarStyleLightContent;
}



@end
