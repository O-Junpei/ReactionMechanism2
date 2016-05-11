//
//  TagView.m
//  ReactionMechanism2
//
//  Created by onojunpei on 2016/04/07.
//  Copyright © 2016年 onojunpei. All rights reserved.
//

#import "TagView.h"

@implementation TagView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
        
        //タグのイメージ
        _TagImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.05, self.frame.size.width*0.05, self.frame.size.width*0.9, self.frame.size.width*0.9)];
        [self addSubview:_TagImage];
        
        //タグのテキストの設定
        _TagText = [[UITextView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.05, self.frame.size.width, self.frame.size.width*0.9, (self.frame.size.height-self.frame.size.width)*0.9)];
        //_TagText.textAlignment = NSTextAlignmentCenter;
        _TagText.font = [UIFont systemFontOfSize:14];
        _TagText.editable = false;
        [self addSubview:_TagText];
    }
    return self;
}





@end
