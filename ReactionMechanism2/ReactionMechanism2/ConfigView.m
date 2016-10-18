//
//  ConfigView.m
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import "ConfigView.h"

//ShareBuble
#define CUSTOM_BUTTON_ID_LINE 100

@interface ConfigView ()

@end

@implementation ConfigView{
    
    NSUserDefaults *myDefaults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    //UserDefaultの読み込み
    myDefaults = [NSUserDefaults standardUserDefaults];
    
    
    //view上部のナビゲーションバーの設定
    _configViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _configViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    _configViewNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:_configViewNav];
    
    //ナビゲーションバーに設置したラベルの設定
    _navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _navLabel.text = @"Config";
    _navLabel.textColor = [UIColor whiteColor];
    _navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_navLabel];
    
    // テーブルビューの設定
    _configTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStyleGrouped];
    _configTableView.delegate = self;
    _configTableView.dataSource = self;
    [self.view addSubview:_configTableView];
    
    
    //広告を表示
    [self setAdmob];
}



#pragma mark -
#pragma mark [TableView関連]


#pragma mark --TableViewのSection数を設定する。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    //リセットボタンは今回は実装しないので、2を返す
}

#pragma mark --TableViewのSection数を設定する。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
            
        case 0:
            //LANGUAGE
            //・言語名
            return 1;
            break;
            
        case 1:
            //OHERES
            //・Share
            return 1;
            break;
            
        case 2:
            //Reset
            //・Reset
            return 1;
            break;
            
        default:
            NSLog(@"ERROR:ClassName=%s:LINE=%d",__PRETTY_FUNCTION__,__LINE__);
            return 1;
            break;
    }
}



#pragma mark --TableViewのセクションのタイトルの設定
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
    
        case 0:
            return @"Langage";
            break;
            
        case 1:
            return @"Others";
            break;
            
        case 2:
            
            return @"Reset";
            break;
            
        default:
            NSLog(@"ERROR:ClassName=%s:LINE=%d",__PRETTY_FUNCTION__,__LINE__);
            return @"erroe";
            break;
    }
}




#pragma mark --TableViewの中身の設定
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //セルの中のラベルの折り返し設定。とりま3
    cell.textLabel.numberOfLines = 3;

    //表示文字の切り分け
    switch (indexPath.section) {
        case 0:
            if ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"japanise"]) {
                cell.textLabel.text = @"Japanise";
            }else{
                cell.textLabel.text = @"English";
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Share";
                    break;
                    
                default:
                    cell.textLabel.text = @"WriteLeviews";
                    break;
            }
            break;
        default:
                    cell.textLabel.text = @"Reset";
            break;
    }
    
    //セル内の文字の色の設定
    cell.textLabel.textColor = [UIColor grayColor];
    
    //セル内のフォントの設定
    cell.textLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    return cell;
}


#pragma mark --セル選択時に動くメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //表示文字の切り分け
    switch (indexPath.section) {
        case 0:
            //言語選択画面が押された
            [self showChangeLangAlert];
            
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    //拡散が押された
                    //拡散用シェアバブルを開く
                    [self showShareBubles];
                    break;
                    
                default:
                    //レビューを書くが押された
                    break;
            }
            break;
        default:
            NSLog(@"リセットが押された");
            break;
    }
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --設定リセットの際に呼ばれる。
-(void)showChangeLangAlert
{
    // Alertの表示
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert addButton:@"English" target:self selector:@selector(englishChosed)];
    [alert addButton:@"Japanise" target:self selector:@selector(japaniseChosed)];
    [alert showSuccess:self title:@"Langage" subTitle:@"Please Chose Language" closeButtonTitle:@"Close" duration:0.0f];
}


#pragma mark --英語名が選ばれた
-(void)englishChosed
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"english" forKey:@"KEY_Language"];
    [ud synchronize];
    [_configTableView reloadData];
}

#pragma mark --日本語が選ばれた
-(void)japaniseChosed
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"japanise" forKey:@"KEY_Language"];
    [ud synchronize];
    [_configTableView reloadData];
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
        case (int)CUSTOM_BUTTON_ID_LINE:
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
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        //ツイッター拡散用
        SLComposeViewController *twitterVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        // 表示する文字
        NSString *tweetStr;
        tweetStr = ([ReactionLibrary isEnglish])? (@"When you want to check, When you want to gaze the reaction mechanism #Reactum")
        :(@"反応機構を確認したいときに、じっくり眺めたいときに #Reactum #反応機構");
        
        [twitterVc setInitialText:tweetStr];
        //[twitterVc addURL:[NSURL URLWithString:@"http://conol.co.jp/apps/chemist/"]];
        
        // 画像をPOSTする場合
        //[twitterVc addImage:[UIImage imageNamed:@"XXXXX"]];
        
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
        NSString *postContent;
        postContent =([ReactionLibrary isEnglish])? (@"When you want to check, When you want to gaze the reaction mechanism #Reactum")
        :(@"反応機構を確認したいときに、じっくり眺めたいときに #Reactum #反応機構");
        
        [facebookPostVC setInitialText:postContent];
        //[facebookPostVC addURL:[NSURL URLWithString:@"http://sciencetools.biz/"]]; // URL文字列
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
    string = ([ReactionLibrary isEnglish])? (@"When you want to check, When you want to gaze the reaction mechanism #Reactum")
    :(@"反応機構を確認したいときに、じっくり眺めたいときに #Reactum #反応機構");
    
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
        mailMessage = ([ReactionLibrary isEnglish])? (@"When you want to check, When you want to gaze the reaction mechanism #Reactum")
        :(@"反応機構を確認したいときに、じっくり眺めたいときに #Reactum #反応機構");
        NSMutableString *bodytxt = [NSMutableString string];
        [bodytxt appendString:mailMessage];
        //[bodytxt appendString:@"http://sciencetools.biz/"];
        
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


#pragma mart - 広告を設定する
- (void)setAdmob{
    
    //広告
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:@"GAD_SIMULATOR_ID",nil];
    
    // 利用可能な広告サイズの定数値は GADAdSize.h で説明されている
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    
    [bannerView_ setCenter:CGPointMake(kGADAdSizeBanner.size.width/2, (self.view.frame.size.height-GAD_SIZE_320x50.height/2)-50)];
    
    // 広告ユニット ID を指定する
    bannerView_.adUnitID = MY_BANNER_UNIT_ID;
    
    // ユーザーに広告を表示した場所に後で復元する UIViewController をランタイムに知らせて
    // ビュー階層に追加する
    bannerView_.rootViewController = self;
    [self.view addSubview:bannerView_];
    
    // 一般的なリクエストを行って広告を読み込む
    [bannerView_ loadRequest:[GADRequest request]];
}

@end
