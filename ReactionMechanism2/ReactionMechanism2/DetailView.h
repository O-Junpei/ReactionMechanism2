//
//  DetailView.h
//  
//
//  Created by onojunpei on 2016/03/26.
//
//

#import <UIKit/UIKit.h>
#import "AAShareBubbles.h"
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface DetailView : UIViewController<UIScrollViewDelegate,MFMailComposeViewControllerDelegate,AAShareBubblesDelegate>{
    UIImageView *iv;
}


@property (strong, nonatomic) UINavigationBar *detailViewNav;
@property (strong, nonatomic) UILabel *navLabel;

@property (strong, nonatomic) NSString *selectedID;
@property (strong, nonatomic) NSArray *sciencePlist;
@property (weak, nonatomic) UIScrollView *scrollView;



@end
