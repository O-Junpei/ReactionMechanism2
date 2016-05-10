//
//  ListView.h
//  
//
//  Created by onojunpei on 2016/01/05.
//
//

#import <UIKit/UIKit.h>
#import "DetailView.h"
#import "ReactionLibrary.h"

@interface ListView : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,UITabBarDelegate>{
}

//Viewの部品
@property (strong, nonatomic) UINavigationBar *listViewNav;
@property (strong, nonatomic) UITableView *listTableView;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) UISearchController *searchController;

//sciencePlistを読み込んだ配列
@property (strong, nonatomic) NSArray *sciencePlist;

//検索結果が入っている
@property (strong, nonatomic) NSMutableArray *searchedResult;

//検索文字列を入れる
@property (strong, nonatomic) NSString *serchBarText;

@end
