//
//  DetailView.h
//  
//
//  Created by onojunpei on 2016/03/26.
//
//

#import <UIKit/UIKit.h>

@interface DetailView : UIViewController


@property (strong, nonatomic) UINavigationBar *detailViewNav;
@property (strong, nonatomic) UILabel *navLabel;

@property (strong, nonatomic) NSString *selectedID;
@property (strong, nonatomic) NSArray *sciencePlist;

@end
