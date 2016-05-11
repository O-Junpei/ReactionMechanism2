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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"SelectedID=%@",_tagID);
    
    //sciecePlistの読み込み
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sciecePlist" ofType:@"plist"];
    _sciencePlist = [NSArray arrayWithContentsOfFile:path];

    //表示用テーブルビューの設定
    _tableViewAry = [NSMutableArray array];

    //表示用のテーブルビューに要素を入れていく
    for(NSDictionary *dic in _sciencePlist)
    {
        //functionの該当要素を入れる
        NSArray *funcAry = [dic objectForKey:@"functionalAry"];
        ([funcAry containsObject:_tagID])?([_tableViewAry addObject:dic]):(nil);
        
        //Reactionsの該当要素を入れる
        NSArray *reactionAry = [dic objectForKey:@"tagAry"];
        ([reactionAry containsObject:_tagID])?([_tableViewAry addObject:dic]):(nil);
    }
    
    //NSLog(@"tableary=%@",_tableViewAry);
    
#pragma mark --ナビゲーションバーの設定
    
    //背景色の設定
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    //view上部のナビゲーションバーの設定
    _tagResultNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _tagResultNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    _tagResultNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:_tagResultNav];
    
    // ナビゲーションアイテムを生成
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *backNavBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backView:)];
    
    // ナビゲーションアイテムに戻るボタンを設置
    navItem.leftBarButtonItem = backNavBtn;
    
    //虫めがねの色の変更
    navItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [_tagResultNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:_tagResultNav];
    
    
    //ナビゲーションバーに設置したラベルの設定
    _navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    _navLabel.text = @"Reaction List";
    _navLabel.textColor = [UIColor whiteColor];
    _navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    _navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_navLabel];
    
#pragma mark [TableView関連]
    
    // テーブルビュー例文
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    
}


#pragma mark -
#pragma mark [TableView関連]

#pragma mark --TableViewの行数設定
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    
    //セル内の文字の色の設定
    cell.textLabel.textColor = [UIColor grayColor];
    
    //セル内のフォントの設定
    cell.textLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    
    //セルの中のラベルの折り返し設定。とりま3
    cell.textLabel.numberOfLines = 3;

    //表示名
    cell.textLabel.text = ([ReactionLibrary isEnglish])?([[_tableViewAry objectAtIndex:indexPath.row] objectForKey:@"ename"]):([[_tableViewAry objectAtIndex:indexPath.row] objectForKey:@"jname"]);
    
    return cell;
}


#pragma mark --セル選択時に動くメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //セル選択の解除
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //選択セルのidを取得
    NSString *selectedID = [[_tableViewAry objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    //NSLog(@"selectedID=%@",selectedID);
    
    //詳細表示画面にidを送る
    DetailView *secondVC = [[DetailView alloc] init];
    secondVC.selectedID = selectedID;
    [self presentViewController: secondVC animated:YES completion: nil];
    
}


#pragma mark --前のViewに戻る
- (void)backView:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:NULL];
}



@end
