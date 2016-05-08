//
//  TagResultView.m
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/04/13.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import "TagResultView.h"

@interface TagResultView (){
    
}

@end

@implementation TagResultView{
    UITableView *listTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"SelectedID=%@",_tagID);
    
    
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    //読み込むプロパティリストのファイルパスを指定
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sciecePlist" ofType:@"plist"];
    //プロパティリストの中身データを取得
    _sciencePlist = [NSArray arrayWithContentsOfFile:path];
    
   _tableViewAry = [NSMutableArray array];

    
    for(NSDictionary *dic in _sciencePlist){
        
        NSArray *ary = [dic objectForKey:@"functionalAry"];
        
        NSLog(@"ary=%@",ary);
        
        
        if ([ary containsObject:_tagID]) {
            [_tableViewAry addObject:dic];
        }
        //NSLog(@"ID:%@",[dic objectForKey:@"id"]);
        //NSLog(@"ID:%@",[dic objectForKey:@"jname"]);
    }
    
    
    
    NSLog(@"tableary=%@",_tableViewAry);
    
    
    
#pragma mark --ナビゲーションバーの設定
    
    //背景色の設定
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    
    //view上部のナビゲーションバーの設定
    self.tagResultNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.tagResultNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    self.tagResultNav.translucent = NO ;
    
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:self.tagResultNav];
    
    // ナビゲーションアイテムを生成
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *backNavBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backView:)];
    
    
    // ナビゲーションアイテムに戻るボタンを設置
    navItem.leftBarButtonItem = backNavBtn;
    
    //虫めがねの色の変更
    navItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [self.tagResultNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:self.tagResultNav];
    
    
    //ナビゲーションバーに設置したラベルの設定
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.navLabel.text = @"Reaction List";
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.navLabel];
    
    /*
    // テーブルビュー例文
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    
    
    */
    
#pragma mark [TableView関連]
    
    
    // テーブルビュー例文
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    
    
}



#pragma mark -
#pragma mark [TableView関連]

#pragma mark --TableViewの行数設定
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    /*
     if (self.tableSegment.selectedSegmentIndex == 1) {
     return [compountAry count];
     }else{
     return [self.searchResults count];
     }
     */
    return [_tableViewAry count];
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
    
    //通常モードかserchモードかでtableに表示する配列の設定
    /*if (self.tableSegment.selectedSegmentIndex == 1) {
     cell.textLabel.text = [compountAry objectAtIndex:indexPath.row];
     }
     else{
     cell.textLabel.text = [self.searchResults objectAtIndex:indexPath.row];
     
     }
     */
    
    
    
    /*
    if ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"japanise"]) {
        cell.textLabel.text = [[_sciencePlist objectAtIndex:indexPath.row] valueForKey:@"jname"];
    }else{
        
        cell.textLabel.text = [[_sciencePlist objectAtIndex:indexPath.row] valueForKey:@"ename"];
    }
    */
    
    
    
    
    cell.textLabel.text = ([ReactionLibrary isEnglish])?([[_tableViewAry objectAtIndex:indexPath.row] objectForKey:@"ename"]):([[_tableViewAry objectAtIndex:indexPath.row] objectForKey:@"jname"]);
    

    
    //セル内の文字の色の設定
    cell.textLabel.textColor = [UIColor grayColor];
    
    //セル内のフォントの設定
    cell.textLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //セルに手作りアクセサリを入れる。
    UIImageView *tableAccesory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableArrow_20.png"]];
    cell.accessoryView = tableAccesory;
    
    return cell;
}


#pragma mark --セル選択時に動くメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"セルが押されたよ");
    
    //[[_tableViewAry objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //選択セルのidを取得
    NSString *selectedID = [[_tableViewAry objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    
    NSLog(@"selectedID=%@",selectedID);
    
    
    //詳細表示画面にidを送る
    DetailView *secondVC = [[DetailView alloc] init];
    secondVC.selectedID = selectedID;
    [self presentViewController: secondVC animated:YES completion: nil];
    
    
    /*
    //選択セルのidを取得
    NSString *selectedID = [[_sciencePlist objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    //詳細表示画面にidを送る
    DetailView *secondVC = [[DetailView alloc] init];
    secondVC.selectedID = selectedID;
    [self presentViewController: secondVC animated:YES completion: nil];
    */
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
