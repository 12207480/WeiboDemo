//
//  NSString+Size.m
//  myCoreText
//
//  Created by SunYong on 14/12/15.
//  Copyright (c) 2014年 tanyang. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    CGSize textSize = CGSizeZero;
    NSString *text = self;
    if (text) {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
        textSize = CGSizeMake(ceil(frame.size.width), ceil(frame.size.height));
    }
    return textSize;
}

@end
