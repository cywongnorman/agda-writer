//
//  CustomTokenCell.h
//  AgdaWriter
//
//  Created by Marko Koležnik on 2. 05. 15.
//  Copyright (c) 2015 koleznik.net. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CustomTokenCell : NSTextAttachmentCell
{
    BOOL highlighted;
    NSFont * defaultFont;
}
-(id)init;
-(id) initWithParentViewController: (id)parentViewController;
-(void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView;
@property NSRange whereToGoRange;
@property id parentViewController;

@end
