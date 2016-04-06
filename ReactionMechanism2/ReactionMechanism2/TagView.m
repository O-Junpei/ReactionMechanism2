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
        
        _TagImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 60, 30, 30)];
        //_TagImage.image = [UIImage imageNamed:@"r0001_ename.png"];
        
        [self addSubview:_TagImage];
        
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0];
    }
    return self;
}



@end
