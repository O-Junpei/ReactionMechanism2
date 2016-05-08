//
//  ListView.m
//  
//
//  Created by onojunpei on 2016/01/05.
//
//

#import "ListView.h"

@interface ListView ()

@end

@implementation ListView{
    UITableView *listTableView;
    NSUserDefaults *myDefaults;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //UserDefaultsの初期設定
    myDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:@"english" forKey:@"KEY_Language"];
    [myDefaults registerDefaults:defaults];
    
    //UITabBar.delegate = self;
    
    
    //キーボード非表示の通知の登録
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardOff:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    
    //viewのセット
    [self setInitialView];
}


//様々な初期設定など
-(void)setInitialView{
#pragma mark --ナビゲーションバーの設定
    
    //背景色の設定
    self.view.backgroundColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    
    //view上部のナビゲーションバーの設定
    self.listViewNav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.listViewNav.barTintColor = [UIColor colorWithRed:(34.0/255.0) green:(138.0/255.0) blue:(251.0/255.0) alpha:1.0];
    self.listViewNav.translucent = NO ;
    
    //ナビゲーションコントローラーによるナビゲーションバーを隠す。
    [self.view addSubview:self.listViewNav];
    
    // ナビゲーションアイテムを生成
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    UIBarButtonItem *serchNavBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchBar:)];
    
    // ナビゲーションアイテムに戻る、サーチボタンを設置
    navItem.rightBarButtonItem = serchNavBtn;
    
    //虫めがねの色の変更
    navItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    // ナビゲーションバーにナビゲーションアイテムを設置
    [self.listViewNav pushNavigationItem:navItem animated:YES];
    [self.view addSubview:self.listViewNav];
    
    
    //ナビゲーションバーに設置したラベルの設定
    self.navLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    self.navLabel.text = @"Reaction List";
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //AxisStd-UltraLight
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.navLabel];
    
    
    //UITableViewの下のアレを消す
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 750)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    // テーブルビュー例文
    listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-50)];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    
    
    
    
#pragma mark --SearchControllerの初期設定
    
    //searchControllerの作成、設置
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchBar.frame = CGRectMake(0, 0, 0, 44.0);
    
    //searchControllerの詳細設定
    self.searchController.searchBar.delegate = self;
    listTableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    NSString *plateHolderStr = ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"japanise"])?( @"検索ワードを入力してください"):(@"ケンサクワードプリーズ(英語で)");
    self.searchController.searchBar.placeholder = plateHolderStr;
    
    
    
    //プロジェクト内のファイルにアクセスできるオブジェクトを宣言
    //読み込むプロパティリストのファイルパスを指定
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"sciecePlist" ofType:@"plist"];
    //プロパティリストの中身データを取得
    _sciencePlist = [NSArray arrayWithContentsOfFile:path];
    
    
    //NSLog(@"%@ry",_sciencePlist);
    _searchedResult = [_sciencePlist mutableCopy];
}




#pragma mark -
#pragma mark [TableView関連]

#pragma mark --TableViewの行数設定
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_searchedResult count];
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
    
    
    //言語の指定
    cell.textLabel.text = ([ReactionLibrary isEnglish])?([[_searchedResult objectAtIndex:indexPath.row] valueForKey:@"ename"]):([[_searchedResult objectAtIndex:indexPath.row] valueForKey:@"jname"]);
   
    
    //セル内の文字の色の設定
    cell.textLabel.textColor = [UIColor grayColor];
    
    //セル内のフォントの設定
    cell.textLabel.font = [UIFont fontWithName:@"AxisStd-UltraLight" size:20];
    
    //セルに手作りアクセサリを入れる。
    UIImageView *tableAccesory = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableArrow_20.png"]];
    cell.accessoryView = tableAccesory;
    
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //検索状態が続いていたら検索を終了させる
    if([self.searchController isActive]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

#pragma mark --セル選択時に動くメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //検索状態が続いていたら検索を終了させる
    if([self.searchController isActive]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    //_serchBarText = _searchController.searchBar.text;
    
    //選択セルのidを取得
    NSString *selectedID = [[_searchedResult objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    //詳細表示画面にidを送る
    DetailView *secondVC = [[DetailView alloc] init];
    secondVC.selectedID = selectedID;
    [self presentViewController: secondVC animated:YES completion: nil];
    
    //セルの選択色の変更
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
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



#pragma mark -
#pragma mark [SearchBar関連]


#pragma mark --サーチバーの文字列が編集されたら呼ばれる。
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    //searchTextを大文字に変換
    NSString *upperSearchString = [searchText uppercaseString];
    
    
    //検索結果の取得
    _searchedResult = [self conjectureSerarch:upperSearchString];
    
    
    //searchTextを保持する
    _serchBarText = [NSMutableString stringWithString:searchText];
    
    /*
    //searchBar中に文字が入っていない時は検索結果に一覧を入れておく。
    if ([searchText isEqualToString:[NSString stringWithFormat:@""]])
    {
        
        ([self isCompountSegment]) ? (resultsOfCompount = compountListAry) : (resultsOfChemiFormula = chemiFormulaAray);
    }*/
    
    //tableViewのリロード。検索結果を反映させる。
    [listTableView reloadData];
     
     
}


#pragma mark --serchBarの編集終了後に動く。(キャンセルボタンが押されたら動く)
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    //検索用TextFieldへ入力した文字の保持
    self.searchController.searchBar.text =_serchBarText;
    
    /*
    _serchBarText = @"";
    
    //検索用TextFieldへ入力した文字の保持
    self.searchController.searchBar.text = _serchBarText;
    
    _searchedResult = [_sciencePlist mutableCopy];
    
    //tableViewのリロード。検索結果を反映させる。
    [listTableView reloadData];*/
}



#pragma mark --Segue で次の Viewに移行する時に選択されたセルのタイトルを渡す。
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    /*
     // identifier が toViewController であることの確認
     if ([[segue identifier] isEqualToString:@"toDetailDictionary"]) {
     DictionaryDetailViewController *vc = (DictionaryDetailViewController*)[segue destinationViewController];
     // 移行先の ViewController に画像名を渡す
     vc.recievedReaction = selectedReaction;
     }
     
     */
}


#pragma mark --化合物用の検索メソッド、検索した語がename,jnameに無いか検索する
- (NSMutableArray *)conjectureSerarch:(NSString *)searchText
{
    
    //検索文字列が空の場合は検索結果を返す。
    if (searchText.length == 0) {
        return [_sciencePlist mutableCopy];
    }
    
    NSMutableArray *reactionNames = [NSMutableArray array];
    
    NSString *langKey;
    ([[myDefaults stringForKey:@"KEY_Language"] isEqualToString:@"japanise"])?(langKey = @"jname"):(langKey = @"ename");
    
    //名前に含まれているか検索する
    for (int i=0; i<[_sciencePlist count]; i++) {
        NSString *serchText = [[_sciencePlist objectAtIndex:i] valueForKey:langKey];
        NSRange searchResult = [serchText rangeOfString:searchText options:NSCaseInsensitiveSearch];
        (searchResult.location != NSNotFound)?([reactionNames addObject:[_sciencePlist objectAtIndex:i]]):(nil);
    }
    return reactionNames;
}


#pragma mark --KeyBoardを閉じた時に呼ばれる
-(void)keyboardOff:(NSNotification *)notification
{
    //検索用TextFieldへ入力した文字の保持
    //タイミングによっては「searchBarTextDidEndEditing」が実行された後にTextFieldがクリアされるため、二重で実行している。
    self.searchController.searchBar.text =_serchBarText;
    
    //検索状態が続いていたら検索を終了させる
    if([self.searchController isActive]) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    
    
    [self.searchController resignFirstResponder];
    
}



#pragma mark --画面描画前に呼ばれる。
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    /*
    //viewのセット
    [self setInitialView];
    
    _searchController.searchBar.text = _serchBarText;
    
    //searchTextを大文字に変換
    NSString *upperSearchString = [_serchBarText uppercaseString];
    
    
    //検索結果の取得
    _searchedResult = [self conjectureSerarch:upperSearchString];
    
    
    //table更新
    [listTableView reloadData];
    
    //テーブルビューを下げる
    if (_serchBarText.length == 0) {
        listTableView.contentOffset = CGPointMake(0, -listTableView.contentInset.top+(self.searchController.searchBar.frame.size.height));
    }else{
        listTableView.contentOffset = CGPointMake(0, -listTableView.contentInset.top);
    }*/
    
    [listTableView reloadData];
   listTableView.contentOffset = CGPointMake(0, -listTableView.contentInset.top+(self.searchController.searchBar.frame.size.height));

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    self.searchController.searchBar.text = _serchBarText;
    
    
    [self.view endEditing:YES];
    
    // UISearchBar からフォーカスを外します。
    [searchBar resignFirstResponder];
    
}

/*
#pragma mark --serchBarの編集終了後に動く。
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    //検索用TextFieldへ入力した文字の保持
    self.searchController.searchBar.text =searchBarStrings;
    
}
*/


#pragma mark --ナビゲーションボタン右上の虫眼鏡が押されたら動く
- (void)showSearchBar:(UIButton *)btn {
    
    //テーブルビューを一番上まで引き上げる。
    [listTableView setContentOffset:CGPointZero animated:YES];

    
}

#pragma mark --StatusBarを白色に
- (UIStatusBarStyle)preferredStatusBarStyle {
    //文字を白くする
    return UIStatusBarStyleLightContent;
}

#pragma mark --画面再読み込み時に呼ばれる


@end
