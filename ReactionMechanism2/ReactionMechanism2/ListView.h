//
//  ListView.h
//  
//
//  Created by onojunpei on 2016/01/05.
//
//

#import <UIKit/UIKit.h>

@interface ListView : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate>{
    
    
}


@property (strong, nonatomic) UINavigationBar *listViewNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (strong, nonatomic) UISearchController *searchController;


@end
