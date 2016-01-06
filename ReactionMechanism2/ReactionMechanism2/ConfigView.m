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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.478 green:0.6902 blue:0.1647 alpha:1.0];
    
    
    //view上部のナビゲーションバーの設定
    self.configViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.configViewNav.barTintColor = [UIColor colorWithRed:0.478 green:0.6902 blue:0.1647 alpha:1.0];
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
    configTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-70) style:UITableViewStyleGrouped];
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
    return 2;
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
            return 3;
            break;
            
        case 2:
            //サウンド
            //・効果音
            //・バイブ設定
            return 4;
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
            //ゲーム設定
            return @"Langage";
            break;
            
        case 1:
            //
            return @"Others";
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
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    cell.textLabel.text = @"aa";
    
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

- (NSInteger)numberOfSections {
    return 2; // セクションは2個とします
}





@end
