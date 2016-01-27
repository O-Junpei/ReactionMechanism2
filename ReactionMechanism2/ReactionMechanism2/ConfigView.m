//
//  ConfigView.m
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/01/05.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import "ConfigView.h"

@interface ConfigView ()

@end

@implementation ConfigView{
    
    UITableView *configTableView;
    NSUserDefaults *myDefaults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    //UserDefaultの読み込み
    myDefaults = [NSUserDefaults standardUserDefaults];
    
    
    //view上部のナビゲーションバーの設定
    self.configViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.configViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    self.configViewNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:self.configViewNav];
    
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
    self.navLabel.text = @"Config";
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.navLabel];
    

    // テーブルビュー例文
    configTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStyleGrouped];
    configTableView.delegate = self;
    configTableView.dataSource = self;
    [self.view addSubview:configTableView];
    
}


#pragma mark --StatusBarを白色に
- (UIStatusBarStyle)preferredStatusBarStyle {
    //文字を白くする
    return UIStatusBarStyleLightContent;
}




#pragma mark -
#pragma mark [TableView関連]


#pragma mark --TableViewのSection数を設定する。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark --TableViewのSection数を設定する。
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
            
        case 0:

            return 1;
            break;
            
        case 1:
            //使い方
            //・使い方
            return 2;
            break;
            
        case 2:
            //サウンド
            //・効果音
            //・バイブ設定
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
    
    //セルの選択時の色を変えない
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
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
                    cell.textLabel.text = @"WriteLeviews";
                    break;
                    
                default:
                    cell.textLabel.text = @"Share";
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
    
    //セルに手作りアクセサリを入れる。
    //UIImageView *tableAccesory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableArrow_20.png"]];
    //cell.accessoryView = tableAccesory;
    
    return cell;
}


#pragma mark --セル選択時に動くメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //表示文字の切り分け
    switch (indexPath.section) {
        case 0:
            NSLog(@"言語選択画面が押された");
            [self showResetAlert];
            
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    NSLog(@"レビューを書くが押された");
                    break;
                    
                default:
                    NSLog(@"拡散が押された");
                    break;
            }
            break;
        default:
            NSLog(@"リセットが押された");
            break;
    }
    
    /*
     //検索状態が続いていたら検索を終了させる
     if([self.searchController isActive]) {
     
     [self dismissViewControllerAnimated:YES completion:nil];
     }
     
     NSString *chemicalFormula;
     
     chemicalFormula = [self.searchResults objectAtIndex:indexPath.row];
     
     //選択された反応名
     selectedReaction = chemicalFormula;
     
     //push
     [self performSegueWithIdentifier:@"toDetailDictionary" sender:self];
     
     //セルの選択色の変更
     [tableView deselectRowAtIndexPath:indexPath animated:YES];*/
    
}

#pragma mark --設定リセットの際に呼ばれる。
-(void)showResetAlert{
    
    // Get started
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    [alert addButton:@"English" target:self selector:@selector(englishChosed)];
    [alert addButton:@"Japanise" target:self selector:@selector(japaniseChosed)];
    [alert showSuccess:self title:@"Langage" subTitle:@"Please Chose Language" closeButtonTitle:@"Close" duration:0.0f];
    
}



-(void)englishChosed{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"english" forKey:@"KEY_Language"];
    [ud synchronize];
    [configTableView reloadData];
}

-(void)japaniseChosed{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"japanise" forKey:@"KEY_Language"];
    [ud synchronize];
    [configTableView reloadData];
}



@end
