//
//  NSString+Size.h
//  myCoreText
//
//  Created by SunYong on 14/12/15.
//  Copyright (c) 2014年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Size)
- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
@end
