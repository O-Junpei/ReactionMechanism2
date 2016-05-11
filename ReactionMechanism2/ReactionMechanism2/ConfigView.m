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



@end
