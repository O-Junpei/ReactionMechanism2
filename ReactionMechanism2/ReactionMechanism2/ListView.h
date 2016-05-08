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

@interface ListView : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>{
    
    
}

@property (strong, nonatomic) UINavigationBar *listViewNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *sciencePlist;
@property (strong, nonatomic) NSMutableArray *searchedResult;

//検索文字列を入れる
@property (strong, nonatomic) NSString *serchBarText;

@end
