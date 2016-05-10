//
//  DetailView.h
//  
//
//  Created by onojunpei on 2016/03/26.
//
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "AAShareBubbles.h"
#import "ReactionLibrary.h"

@interface DetailView : UIViewController<UIScrollViewDelegate,MFMailComposeViewControllerDelegate,AAShareBubblesDelegate>{
    UIImageView *iv;
}

//View
@property (strong, nonatomic) UINavigationBar *detailViewNav;
@property (strong, nonatomic) UILabel *navLabel;
@property (weak, nonatomic) UIScrollView *scrollView;

//sciencePlistの中身が入る
@property (strong, nonatomic) NSArray *sciencePlist;

//選択された反応のID
@property (strong, nonatomic) NSString *selectedID;

//選択された反応のDic
@property (strong, nonatomic) NSDictionary *resultDic;

@end
