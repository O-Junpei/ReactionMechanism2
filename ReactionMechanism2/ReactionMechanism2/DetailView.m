//
//  DetailView.m
//  
//
//  Created by onojunpei on 2016/03/26.
//
//

#import "DetailView.h"

//ShareBuble
#define CUSTOM_BUTTON_ID_LINE 100
#define EXPORT_BUTTON_ID_LINE 101


@interface DetailView (){
}

@end

@implementation DetailView

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"DetailViewに遷移したよ");
    self.view.backgroundColor = [UIColor whiteColor];
    
#pragma mark --plistの読み込み
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    //読み込むプロパティリストのファイルパスを指定
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sciecePlist" ofType:@"plist"];
    
    //プロパティリストの中身データを取得
    _sciencePlist = [NSArray arrayWithContentsOfFile:path];
    
    //欲しい配列を取得する
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"id", self.selectedID];
    _resultDic = [[_sciencePlist filteredArrayUsingPredicate:predicate] firstObject];
    
    //NSLog(@"results:%@", _resultDic);
    
    //ナビゲーションバーのセット
    [self setNavBar];
    [self setScrView];
}


#pragma mark --ナビゲーションバーをセットする
- (void)setNavBar
{
    //背景色の設定
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    //ナビゲーションバーの設定
    NSString *labelText;
    labelText = ([ReactionLibrary isEnglish])?([_resultDic valueForKey:@"ename"]):([_resultDic valueForKey:@"jname"]);
    
    //view上部のナビゲーションバーの設定
    _detailViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _detailViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    _detailViewNav.translucent = NO ;
    
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
    [_detailViewNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:_detailViewNav];
    
    //ナビゲーションバーに設置したラベルの設定
    _navLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, self.view.frame.size.width-100, 44)];
    _navLabel.numberOfLines = 2;
    _navLabel.text = labelText;
    _navLabel.textColor = [UIColor whiteColor];
    _navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    _navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_navLabel];
}


#pragma mark --スクリールビューのセット
- (void)setScrView
{
    //スクリールビュ
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    sv.backgroundColor = [UIColor blackColor];
    sv.maximumZoomScale = 2.5;
    sv.minimumZoomScale = 1.0;
    sv.delegate = self;
    
    iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    
    //日本語か英語かで表示画像を切り替える
    NSString *fileName;
    fileName = ([ReactionLibrary isEnglish])?([_selectedID stringByAppendingString:@"_ename.png"]):([_selectedID stringByAppendingString:@"_jname.png"]);
    
    UIImage *img = [UIImage imageNamed:fileName];
    iv.image = img;
    [sv addSubview:iv];

    [self.view addSubview:sv];
}


#pragma mark --ScrillViewのデリゲートメソッド
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return iv;
}


#pragma mark --前のViewに戻る
- (void)backView:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark --アプリをシェアする
- (void)shareApp:(UIButton *)btn
{
    //拡散用シェアバブルを開く
    [self showShareBubles];
}


#pragma mark - 各種拡散系
#pragma mark --ShareBubleで拡散する
- (void) showShareBubles
{
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
    //add Line Icon
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"lineCustumIcon"]
                          backgroundColor:[UIColor colorWithRed:(float)27/255 green:(float)183/255 blue:(float)31/255 alpha:1.0]
                              andButtonId:CUSTOM_BUTTON_ID_LINE];
    
    //add Export Icon
    [shareBubbles addCustomButtonWithIcon:[UIImage imageNamed:@"exportCustumIcon"]
                          backgroundColor:[UIColor colorWithRed:(float)232/255 green:(float)86/255 blue:(float)30/255 alpha:1.0]
                              andButtonId:EXPORT_BUTTON_ID_LINE];
    
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
        case EXPORT_BUTTON_ID_LINE:
            [self savePhoto];
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
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        //ツイッター拡散用
        SLComposeViewController *twitterVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // 表示する文字
        NSString *tweetStr;
        tweetStr = ([ReactionLibrary isEnglish])?([_resultDic valueForKey:@"ename"]):([_resultDic valueForKey:@"jname"]);
        [twitterVc setInitialText:tweetStr];
        
        //URLを追加する場合
        //[twitterVc addURL:[NSURL URLWithString:@"http://conol.co.jp/apps/chemist/"]];
        
        //画像をPOSTする場合
        NSString *fileName;
        fileName = ([ReactionLibrary isEnglish])?([_selectedID stringByAppendingString:@"_ename.png"]):([_selectedID stringByAppendingString:@"_jname.png"]);
        [twitterVc addImage:[UIImage imageNamed:fileName]];
        
        [self presentViewController:twitterVc animated:YES completion:nil];
    }
    else
    {
        NSString *alertTitle;
        alertTitle = ([ReactionLibrary isEnglish])?(@"Failed"):(@"投稿失敗しました");
        NSString *alertMessage;
        alertMessage = ([ReactionLibrary isEnglish])?(@"Please install Twitter App."):(@"Twitterアプリをインストール後に拡散機能をお使いください。");
        [self shareFailAlart:alertTitle message:alertMessage];
    }
}


#pragma mark --FaceBookで拡散する
- (void) spreadOnFaceBook
{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookPostVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //POSTするテキスト
        NSString *postContent;
        postContent = ([ReactionLibrary isEnglish])?([_resultDic valueForKey:@"ename"]):([_resultDic valueForKey:@"jname"]);
        [facebookPostVC setInitialText:postContent];
        
        //POSTするURL
        //[facebookPostVC addURL:[NSURL URLWithString:@"http://sciencetools.biz/"]]; // URL文字列
        
        // 画像をPOSTする場合
        NSString *fileName;
        fileName = ([ReactionLibrary isEnglish])?([_selectedID stringByAppendingString:@"_ename.png"]):([_selectedID stringByAppendingString:@"_jname.png"]);
        [facebookPostVC addImage:[UIImage imageNamed:fileName]];
        
        [self presentViewController:facebookPostVC animated:YES completion:nil];
    }
    else
    {
        NSString *alertTitle;
        alertTitle = ([ReactionLibrary isEnglish])?(@"Failed"):(@"投稿失敗しました");
        NSString *alertMessage;
        alertMessage = ([ReactionLibrary isEnglish])?(@"Please install FaceBook App."):(@"FaceBookアプリをインストール後に拡散機能をお使いください。");
        [self shareFailAlart:alertTitle message:alertMessage];
    }
}


#pragma mark --LINEで拡散する
- (void) spreadOnLINE
{
    NSString *string;
    string = ([ReactionLibrary isEnglish])?([_resultDic valueForKey:@"ename"]):([_resultDic valueForKey:@"jname"]);
    
    string = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    NSString *LINEUrlString = [NSString stringWithFormat:@"line://msg/text/%@", string];
    
    //LINEがインストールされているか確認。されていなければアラート
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"line://"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:LINEUrlString]];
    }
    else
    {
        NSString *alertTitle;
        alertTitle = ([ReactionLibrary isEnglish])?(@"Failed"):(@"投稿失敗しました");
        NSString *alertMessage;
        alertMessage = ([ReactionLibrary isEnglish])?(@"Please install LINE App."):(@"LINEアプリをインストール後に拡散機能をお使いください。");
        [self shareFailAlart:alertTitle message:alertMessage];
    }
}


#pragma mark --画像データとして保存する
- (void) savePhoto
{
    //保存する画像名の取得
    NSString *fileName;
    fileName = ([ReactionLibrary isEnglish])?([_selectedID stringByAppendingString:@"_ename.png"]):([_selectedID stringByAppendingString:@"_jname.png"]);
    
    //保存する画像を指定
    UIImage *image = [UIImage imageNamed:fileName];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(savingImageIsFinished:didFinishSavingWithError:contextInfo:), nil);
}

// 完了を知らせる
- (void) savingImageIsFinished:(UIImage *)_image didFinishSavingWithError:(NSError *)_error contextInfo:(void *)_contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    alertMessage = ([ReactionLibrary isEnglish])?(@"Please install LINE App."):(@"LINEアプリをインストール後に拡散機能をお使いください。");
    
    
    //エラーの時のアラート
    if(_error)
    {
        //エラーのとき
        alertTitle = ([ReactionLibrary isEnglish])?(@"Failed"):(@"失敗しました");
        alertMessage = ([ReactionLibrary isEnglish])?(@"Unable to save image to Photo Alubum."):(@"画像の保存ができませんでした。");
    }
    else
    {
        //保存できたとき
        alertTitle = ([ReactionLibrary isEnglish])?(@"Saved"):(@"保存しました");
        alertMessage = ([ReactionLibrary isEnglish])?(@"Save the image is complete."):(@"画像を保存しました。");
    }
    [self shareFailAlart:alertTitle message:alertMessage];
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
        NSString *mailSUbject;
        mailSUbject = ([ReactionLibrary isEnglish])?(@"Reactum"):(@"四択化学");
        [picker setSubject:mailSUbject];
        
        // メール本文
        NSString *mailMessage;
        mailMessage = ([ReactionLibrary isEnglish])?([_resultDic valueForKey:@"ename"]):([_resultDic valueForKey:@"jname"]);
        NSMutableString *bodytxt = [NSMutableString string];
        [bodytxt appendString:mailMessage];
        
        //URL
        //[bodytxt appendString:@"http://sciencetools.biz/"];
        
        
        //POSTする画像
        NSString *fileName;
        fileName = ([ReactionLibrary isEnglish])?([_selectedID stringByAppendingString:@"_ename.png"]):([_selectedID stringByAppendingString:@"_jname.png"]);
        
        //保存する画像を指定
        UIImage *image = [UIImage imageNamed:fileName];
        NSData *imgData = [[NSData alloc] initWithData:UIImagePNGRepresentation(image)];
        [picker addAttachmentData:imgData mimeType:@"image/png" fileName:fileName];
        
        [picker setMessageBody:bodytxt isHTML:NO];  // HTMLメールの場合は「YES」
        
        // メールビュー表示
        [self presentViewController:picker animated:YES completion:nil];
    }
    else
    {
        // メール設定が行われていない場合
        NSString *alertTitle;
        alertTitle = ([ReactionLibrary isEnglish])?(@"Failed"):(@"投稿失敗しました");
        NSString *alertMessage;
        alertMessage = ([ReactionLibrary isEnglish])?(@"Please refer to the setting of the mail."):(@"Mail設定を済ませてから拡散機能をお使いください。");
        [self shareFailAlart:alertTitle message:alertMessage];
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



@end
